#version 450
layout(location = 0) in vec4 vertex;
layout(location = 0) uniform mat4 matrix;
void main() {
    gl_Position = matrix * vertex;
}
