// var VSHADER_SOURCE =
// 	"attribute vec4 a_Position;\n" +
// 	"void main() {\n" +
// 	" gl_Position = a_Position;\n" +
// 	" gl_PointSize = 10.0;\n" +
// 	"}\n";

// var FSHADER_SOURCE =
// 	// Set the point size
// 	"void main() {\n" + " gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n" + "}\n";

const main = async () => {
	// Retrieve <canvas> element
	// var canvas = document.getElementById("webgl");

	const canvas: HTMLCanvasElement = document.getElementById(
		"canvas"
	) as HTMLCanvasElement;
	const gl: WebGLRenderingContext = canvas.getContext("webgl")!;

	// var gl = getWebGLContext(canvas);
	if (!gl) {
		console.log("Failed to get the rendering context for WebGL");
		return;
	}

	// if (!initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE)) {
	// 	console.log("Failed to initialize shaders.");
	// 	return;
	// }

	var a_Position = gl.getAttribLocation(gl.createProgram, "a_Position");
	if (a_Position < 0) {
		console.log("Failed to get the storage location of a_Position");
		return;
	}

	canvas.onmousedown = function (ev) {
		click(ev, gl, canvas, a_Position);
	};

	gl.clear(gl.COLOR_BUFFER_BIT);
};

var g_points: number[] = []; // The array for a mouse press function click(ev, gl, canvas, a_Position) {
function click(ev, gl, canvas, a_Position) {
	let x = ev.clientX;
	var y = ev.clientY; // y coordinate of a mouse pointer
	var rect = ev.target.getBoundingClientRect();
	x = (x - rect.left - canvas.height / 2) / (canvas.height / 2);
	console.log(x);
	y = (canvas.width / 2 - (y - rect.top)) / (canvas.width / 2);
	console.log(y);
	// Store the coordinates to g_points array
	g_points.push(x);
	g_points.push(y);
	gl.clear(gl.COLOR_BUFFER_BIT);
	var len = g_points.length;
	for (var i = 0; i < len; i += 2) {
		// Pass the position of a point to a_Position variable
		gl.vertexAttrib3f(a_Position, g_points[i], g_points[i + 1], 0.0);
		// Draw a point
		gl.drawArrays(gl.POINTS, 0, 1);
	}
}

window.onload = main;
