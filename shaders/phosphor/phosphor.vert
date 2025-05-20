#version 440

layout(location = 0) in vec4 vertex;

layout(location = 0) out vec2 fragCoord;

layout(std140, binding = 0) uniform buf {
    mat4 matrix;
    float opacity;
    vec4 color;
} ubuf;

void main() {
    gl_Position = ubuf.matrix * vertex;
    // Pass through the point coordinates for the fragment shader
    fragCoord = vertex.xy;
}
