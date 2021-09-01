import * as defaultShaders from './default-shader';
import * as cubemap from './cubemap';
import * as gltf from 'webgl-gltf';
import * as camera from './camera';
import * as renderer from './renderer';
// import * as inputs from './inputs';
// import * as request from './requests';
// import axios from 'axios';
import * as socket from 'socket.io-client'

const io = socket.io('http://localhost:8084');

const canvas: HTMLCanvasElement = document.getElementById('canvas') as HTMLCanvasElement;
const gl: WebGLRenderingContext = canvas.getContext('webgl')!;

const cam: camera.Camera = {
    rX: 0.0,
    rY: 0.0,
    distance: 3.0
}

io.on('camera_updated', (data: any) => {
    cam.rX = data.rX;
    cam.rY = data.rY;
    cam.distance = data.distance;
})

const setSize = () => {
    const devicePixelRatio = window.devicePixelRatio || 1;
    canvas.width = window.innerWidth * devicePixelRatio;
    canvas.height = window.innerHeight * devicePixelRatio;
    gl.viewport(0, 0, canvas.width, canvas.height);
}

// const rotate = (delta: inputs.Position) => {
//     cam.rX += delta.y;
//     cam.rY += delta.x;
// };

// const zoom = (delta: number) => {
//     cam.distance *= 1.0 + delta;
//     if (cam.distance < 0.0) cam.distance = 0.0;
// };

//inputs.listen(canvas, rotate, zoom);

if (!gl) alert('WebGL not available');

// const pre = async () => {
//     let modelId = request.getParameter('model');
//     if (!modelId) throw new Error('Missing model id in parameters');
    

//     let response = await axios.post('http://localhost:8084/api/model', {model: parseInt(modelId)});
//     if (response.status === 200) {
//         let url = response.data.url;
//         console.log(url);
//     }
// }

const init = async () => {
    gl.clearColor(0.3, 0.3, 0.3, 1.0);
    gl.enable(gl.DEPTH_TEST);

    window.onresize = () => { setSize(); }
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
    const model = await gltf.loadModel(gl, `https://edugo-files.s3.af-south-1.amazonaws.com/test_models/waterbottle/waterbottle.gltf`);

    cubemap.bind(gl, environment, uniforms.brdfLut, uniforms.environmentDiffuse, uniforms.environmentSpecular);

    render(uniforms, model);
}

const render = (uniforms: defaultShaders.DefaultShader, model: gltf.Model) => {
    // gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    gl.clear(gl.COLOR_BUFFER_BIT);

    const cameraMatrix = camera.update(cam, canvas.width, canvas.height);
    gl.uniform3f(uniforms.cameraPosition, cameraMatrix.position[0], cameraMatrix.position[1], cameraMatrix.position[2]);
    gl.uniformMatrix4fv(uniforms.pMatrix, false, cameraMatrix.pMatrix);
    gl.uniformMatrix4fv(uniforms.vMatrix, false, cameraMatrix.vMatrix);

    renderer.renderModel(gl, model, model.rootNode, model.nodes[model.rootNode].localBindTransform, uniforms)

    requestAnimationFrame(() => render(uniforms, model));
}

window.onload = init;