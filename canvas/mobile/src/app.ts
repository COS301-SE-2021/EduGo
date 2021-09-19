import * as defaultShaders from './default-shader';
import * as cubemap from './cubemap';
import * as gltf from 'webgl-gltf';
import * as camera from './camera';
import * as renderer from './renderer';
import * as request from './requests';
import * as helper from './helper';
import axios from 'axios';
import * as socket from 'socket.io-client'

//const BACKEND = 'http://edugo-backend.southafricanorth.cloudapp.azure.com:8081'
const BACKEND = 'http://localhost:8080'

const io = socket.io(BACKEND);

const canvas: HTMLCanvasElement = document.getElementById('canvas') as HTMLCanvasElement;
const gl: WebGLRenderingContext = canvas.getContext('webgl')!;
const canvas2: HTMLCanvasElement = document.getElementById('canvas2') as HTMLCanvasElement;
const ctx: CanvasRenderingContext2D = canvas2.getContext("2d")!;

let prevCoords = { x: 0, y: 0 };
let newLine = true;

const setSize = () => {
    const devicePixelRatio = window.devicePixelRatio || 1;
    canvas.width = window.innerWidth * devicePixelRatio;
    canvas.height = window.innerHeight * devicePixelRatio;
    canvas2.width = window.innerWidth * devicePixelRatio;
	canvas2.height = window.innerHeight * devicePixelRatio;
    gl.viewport(0, 0, canvas.width, canvas.height);
}

const normalizeWidth = (x: number, width: number): number => {
    let windowWidth = window.innerWidth;
    let windowMidpoint = windowWidth / 2;
    let midpoint = width / 2;
    let newX = x - midpoint;
    return windowMidpoint + newX;
}

const cam: camera.Camera = {
    rX: 0.0,
    rY: 0.0,
    distance: 3.0
}

io.on('camera_updated', (data: any) => {
    cam.rX = data.rX;
    cam.rY = data.rY;
    cam.distance = data.distance;
});

// io.on('ratio_updated', (data: any) => {
//     const devicePixelRatio = window.devicePixelRatio || 1;
//     const ratio = Number(data);
//     let height = window.innerHeight * devicePixelRatio;
//     let width = height * ratio;
//     canvas.width = width;
//     canvas.height = height;
//     gl.viewport(0, 0, width, height);
// });

io.on('draw_updated', (data: any) => {
    let ratio = window.devicePixelRatio || 1;
    ctx.beginPath();
	ctx.lineWidth = data.width;
	ctx.lineCap = "round";
	ctx.strokeStyle = data.colour;
    data.coord.x = normalizeWidth(data.coord.x, data.pageWidth);
    data.coord.y = data.coord.y + data.offset
	ctx.moveTo(data.coord.x * ratio, data.coord.y * ratio);
	//reposition(event);
	!newLine ? ctx.lineTo(prevCoords.x * ratio, prevCoords.y * ratio) : ctx.lineTo(data.coord.x * ratio, data.coord.y * ratio);
	ctx.stroke();
    prevCoords = data.coord;
    newLine = false;
});

io.on('clear_draw', () => {
    // canvas2.style.cursor = "not-allowed";
    // canvas2.style.pointerEvents = "none";
    ctx.clearRect(0, 0, canvas2.width, canvas2.height);
    newLine = true;
});

if (!gl) alert('WebGL not available');

const identify = () => {
    let token = request.getParameter('token');
    if (!token) {
        alert('Missing token in parameters');
        throw new Error('Missing token in parameters');
    }

    let code = request.getParameter('code');
    if (!code) {
        alert('Missing code in parameters');
        throw new Error('Missing code in parameters');
    }
    io.emit('identify_student', {token, code});
}

io.on('accepted_student', (data: any) => {
    if (!('link' in data)) {
        alert('Missing link in response');
        throw new Error('Missing link in response');
    }

    // if (!('ratio' in data)) {
    //     alert('Missing ratio in response');
    //     throw new Error('Missing ratio in response');
    // }

    if (data.link == null) {
        alert('Link is null');
        throw new Error('Link is null');
    }

    const devicePixelRatio = window.devicePixelRatio || 1;
    //const ratio = data.ratio;
    let height = window.innerHeight * devicePixelRatio;
    //let width = height * ratio;
    // canvas.width = width;
    // canvas.height = height;
    // canvas2.width = width;
	// canvas2.height = height;
    // gl.viewport(0, 0, width, height);

    init(data.link);
})

//Initializes the canvas that is passed in to disables
//I.e. canvas 2, the transaprent one
const initCanvas = (canvas: HTMLCanvasElement) => {
	canvas.style.cursor = "not-allowed";
	canvas.style.pointerEvents = "none";
};

const init = async (url: string) => {
    canvas2.style.cursor = "auto";
	canvas2.style.pointerEvents = "auto";

    gl.clearColor(0.7, 0.7, 0.7, 1.0);
    gl.enable(gl.DEPTH_TEST);

    //window.onresize = () => { setSize(); }
    setSize();

    const program = gl.createProgram();
    if (program === null) throw new Error('GL Create Program failed');

    const vertex_shader_content = await (await fetch('/shaders/vertex.glsl')).text();
    const fragment_shader_content = await (await fetch('/shaders/fragment.glsl')).text();

    const vertex_shader = gl.createShader(gl.VERTEX_SHADER);
    const fragment_shader = gl.createShader(gl.FRAGMENT_SHADER);

    if (vertex_shader === null || fragment_shader === null) throw new Error('GL Create Shader failed');

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
        throw new Error(`GL Program link failed: ${gl.getProgramInfoLog(program)}`);

    gl.useProgram(program);

    const uniforms = defaultShaders.getUniformLocations(gl, program);

    const environment = await cubemap.load(gl);
    const model = await gltf.loadModel(gl, helper.getGltfLink(url));

    cubemap.bind(gl, environment, uniforms.brdfLut, uniforms.environmentDiffuse, uniforms.environmentSpecular);

    render(uniforms, model);
}

const render = (uniforms: defaultShaders.DefaultShader, model: gltf.Model) => {
    gl.clear(gl.COLOR_BUFFER_BIT);

    const cameraMatrix = camera.update(cam, canvas.width, canvas.height);
    gl.uniform3f(uniforms.cameraPosition, cameraMatrix.position[0], cameraMatrix.position[1], cameraMatrix.position[2]);
    gl.uniformMatrix4fv(uniforms.pMatrix, false, cameraMatrix.pMatrix);
    gl.uniformMatrix4fv(uniforms.vMatrix, false, cameraMatrix.vMatrix);

    renderer.renderModel(gl, model, model.rootNode, model.nodes[model.rootNode].localBindTransform, uniforms)

    requestAnimationFrame(() => render(uniforms, model));
}

window.onload = identify;