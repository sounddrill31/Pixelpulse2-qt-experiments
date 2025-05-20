#version 440

layout(location = 0) in vec2 fragCoord;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 matrix;
    float opacity;
    vec4 color;
} ubuf;

void main() {
    float dist = length(gl_PointCoord - vec2(0.5)) * 2.0;
    fragColor = ubuf.color * ubuf.opacity * (1.0 - dist);
    // Uncomment if you want to discard fragments outside the point circle
    // if(dist > 1.0)
    //    discard;
}
