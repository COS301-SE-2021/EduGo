import * as defaultShaders from './default-shader';
import * as cubemap from './cubemap';
import * as gltf from 'webgl-gltf';
import * as camera from './camera';
import * as renderer from './renderer';
import * as inputs from './inputs';
import * as request from './requests';
import * as helper from './helper';
import axios from 'axios';
import * as socket from 'socket.io-client';

const BACKEND = 'http://edugo-backend.southafricanorth.cloudapp.azure.com:8081'
//const BACKEND = 'http://localhost:8080'

const io = socket.io(BACKEND);
let code: string = '';

const canvas: HTMLCanvasElement = document.getElementById('canvas') as HTMLCanvasElement;
const gl: WebGLRenderingContext = canvas.getContext('webgl')!;
const canvas2: HTMLCanvasElement = document.getElementById("canvas2") as HTMLCanvasElement;


const cam: camera.Camera = {
	rX: 0.0,
	rY: 0.0,
	distance: 3.0,
};

const setSize = () => {
    const devicePixelRatio = window.devicePixelRatio || 1;
    canvas.width = window.innerWidth * devicePixelRatio;
    canvas.height = window.innerHeight * devicePixelRatio;
    canvas2.width = window.innerWidth * devicePixelRatio;
	canvas2.height = window.innerHeight * devicePixelRatio;
    io.emit('new_ratio', window.innerWidth / window.innerHeight);
    gl.viewport(0, 0, canvas.width, canvas.height);
}

const rotate = (delta: inputs.Position) => {
	cam.rX += delta.y;
	cam.rY += delta.x;
};

const zoom = (delta: number) => {
	cam.distance *= 1.0 + delta;
	if (cam.distance < 0.0) cam.distance = 0.0;
};

//controls moving with mouse
inputs.listen(canvas, rotate, zoom);

if (!gl) alert("WebGL not available");

const identify = async () => {
    let token = request.getParameter('token');
    if (!token) {
        alert('Missing token in parameters');
        throw new Error('Missing token in parameters')
    }

    io.emit('identify_educator', {
        token: token,
        ratio: window.innerWidth / window.innerHeight
    });
}

io.on('accepted_educator', async (data: any) => {
    document.getElementById('code')!.innerText = data.code;
    code = data.code;

    let modelId = request.getParameter('model');
    if (!modelId) {
        alert('Missing model id in parameters');
        throw new Error('Missing model id in parameters')
    };
    
    let response = await axios.post(
        `${BACKEND}/api/getVirtualEntity`, 
        { virtualEntityId: parseInt(modelId!) },
        {headers: {authorization: `Bearer ${request.getParameter('token') || ''}`}}
    );
    if (response.status === 200) {
        let {data} = response;
        if ('model' in data && 'fileLink' in data.model) {
            let url = data.model.fileLink;
            io.emit('set_link', {link: url});
            init(url);
        }
    }
    else {
        let errorText = `Error loading model; CODE: ${response.status}`;
        alert(errorText);
        throw new Error(errorText);
    }
});

io.on("declined", (data: any) => {
	alert(data);
	throw new Error(data);
});

//url?: string
const init = async (url: string) => {
	initCanvas(canvas2);

	gl.clearColor(0.7, 0.7, 0.7, 1.0);
	gl.enable(gl.DEPTH_TEST);

	window.onresize = () => { setSize(); };
	setSize();

	const program = gl.createProgram();
	if (program === null) throw new Error("GL Create Program failed");

	const vertex_shader_content = await (
		await fetch("/shaders/vertex.glsl")
	).text();
	const fragment_shader_content = await (
		await fetch("/shaders/fragment.glsl")
	).text();

	const vertex_shader = gl.createShader(gl.VERTEX_SHADER);
	const fragment_shader = gl.createShader(gl.FRAGMENT_SHADER);

	if (vertex_shader === null || fragment_shader === null)
		throw new Error("GL Create Shader failed");

	gl.shaderSource(vertex_shader, vertex_shader_content);
	gl.shaderSource(fragment_shader, fragment_shader_content);

	gl.compileShader(vertex_shader);
	gl.compileShader(fragment_shader);

	if (!gl.getShaderParameter(vertex_shader, gl.COMPILE_STATUS))
		throw new Error(`GL Vertex Shader compile failed: ${gl.getShaderInfoLog(vertex_shader)}`);
	if (!gl.getShaderParameter(fragment_shader, gl.COMPILE_STATUS))
		throw new Error(`GL Fragment Shader compile failed: ${gl.getShaderInfoLog(fragment_shader)}`);

	gl.attachShader(program, vertex_shader);
	gl.attachShader(program, fragment_shader);

	gl.linkProgram(program);

	if (!gl.getProgramParameter(program, gl.LINK_STATUS))
		throw new Error(
			`GL Program link failed: ${gl.getProgramInfoLog(program)}`
		);

	gl.useProgram(program);

	const uniforms = defaultShaders.getUniformLocations(gl, program);

	const environment = await cubemap.load(gl);
	const model = await gltf.loadModel(gl, helper.getGltfLink(url));

	cubemap.bind(
		gl,
		environment,
		uniforms.brdfLut,
		uniforms.environmentDiffuse,
		uniforms.environmentSpecular
	);

	//Listen is the 'engage with model' button is pressed
	document
		.getElementById("engagebutton")
		?.addEventListener("click", engageButton);

	//Loisten if the 'draw on model' button is pressed
	document
		.getElementById("drawbutton")
		?.addEventListener("click", drawButton);

	document
		.getElementById("sliderrange")
		?.addEventListener("input", getLineWidth);

	//document.getElementById("eraserbutton")?.addEventListener("click", eraser);

	//Render everything
	render(uniforms, model);
};
//---------------------------------------------------------------------------------//
//Start of Canvas drawing feature helper functions

//These functions change the colour of the pen when the
//radio button is clicked. It calls the changeColour function
let colourOfPen = 'black';
document.getElementById("red")!.addEventListener("click", changeColour);
document.getElementById("green")!.addEventListener("click", changeColour);
document.getElementById("yellow")!.addEventListener("click", changeColour);
document.getElementById("olive")!.addEventListener("click", changeColour);
document.getElementById("orange")!.addEventListener("click", changeColour);
document.getElementById("teal")!.addEventListener("click", changeColour);
document.getElementById("blue")!.addEventListener("click", changeColour);
document.getElementById("violet")!.addEventListener("click", changeColour);
document.getElementById("purple")!.addEventListener("click", changeColour);
document.getElementById("pink")!.addEventListener("click", changeColour);
document.getElementById("white")!.addEventListener("click", changeColour);
document.getElementById("black")!.addEventListener("click", changeColour);

//This function is the main function to
//change the the pen colour
function changeColour(colour) {
	colourOfPen = colour.srcElement.id;
}

//This function is the main function for
//changing the pen width
let widthOfLine = 1;
function getLineWidth(width) {
	widthOfLine = width.srcElement.value;
}

//This function is used to disable the canvas2 features
//and clear any annotations currently on the canvas. This
//function is called when the 'engage' button is clicked
function engageButton() {
	canvas2.style.cursor = "not-allowed";
	canvas2.style.pointerEvents = "none";
	ctx.clearRect(0, 0, canvas2.width, canvas2.height);
    io.emit('clear_draw');
}

//This function is used to enable the canvas2 features
//and enables the draw functionality to annotate the 3d
// model on the transparent canvas2. This function is
//called when the 'draw' button is clicked
function drawButton() {
	canvas2.style.cursor = "auto";
	canvas2.style.pointerEvents = "auto";
	clickUp();
	clickDown();
}

//This function calls the 'start drawing' function
//when the mouse is clicked down on the transparent canvas2
function clickUp() {
	canvas2.addEventListener("mousedown", start);
}

//This function calls the 'stop drawing' function
//when the mouse is clicked up on the transparent canvas2
function clickDown() {
	canvas2.addEventListener("mouseup", stop);
}

//gets the 2d canvas
const ctx = canvas2.getContext("2d")!;

//Stors the co-ordinates
let coord = { x: 0, y: 0 };

//The start function which starts
//the drawing process on the 3d model
function start(event) {
	document.addEventListener("mousemove", draw);
	reposition(event);
}

//The reposition function which will
//register our mouse position.
function reposition(event) {
	coord.x = event.clientX - canvas2.offsetLeft;
	coord.y = event.clientY - canvas2.offsetTop;
}

//The start function which starts
//the drawing process on the 3d model
function stop() {
	document.removeEventListener("mousemove", draw);
}

//This is the main function for the draw feature.
//It is used in the start and stop functions
function draw(event) {
	let ratio = window.devicePixelRatio;
	let offset = document.getElementById('code')?.offsetHeight || 0;
	ctx.beginPath();
	ctx.lineWidth = widthOfLine;
	ctx.lineCap = "round";
	ctx.strokeStyle = colourOfPen;
	ctx.moveTo(coord.x * ratio, coord.y * ratio);
	reposition(event);
	ctx.lineTo(coord.x * ratio, coord.y * ratio);
	ctx.stroke();
    let data: any = {
        width: widthOfLine,
        colour: colourOfPen,
        coord: coord,
		pageWidth: window.innerWidth,
		offset: offset
    }
    io.emit('new_draw', data);
}

//Initializes the canvas that is passed in to disables
//I.e. canvas 2, the transaprent one
const initCanvas = (canvas: HTMLCanvasElement) => {
	canvas.style.cursor = "not-allowed";
	canvas.style.pointerEvents = "none";
};

//End of Canvas drawing feature helper functions
//---------------------------------------------------------------------------------//

const render = (uniforms: defaultShaders.DefaultShader, model: gltf.Model) => {
	// gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

	gl.clear(gl.COLOR_BUFFER_BIT);

	const cameraMatrix = camera.update(cam, canvas.width, canvas.height);
	gl.uniform3f(
		uniforms.cameraPosition,
		cameraMatrix.position[0],
		cameraMatrix.position[1],
		cameraMatrix.position[2]
	);
	gl.uniformMatrix4fv(uniforms.pMatrix, false, cameraMatrix.pMatrix);
	gl.uniformMatrix4fv(uniforms.vMatrix, false, cameraMatrix.vMatrix);

	io.emit("new_camera", cam);

	gl.drawArrays(gl.POINTS, 0, 1);

	renderer.renderModel(
		gl,
		model,
		model.rootNode,
		model.nodes[model.rootNode].localBindTransform,
		uniforms
	);

	requestAnimationFrame(() => render(uniforms, model));
};

window.onload = identify;
