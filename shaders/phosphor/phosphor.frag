#version 450
layout(location = 1) uniform float opacity;
layout(location = 2) uniform vec4 color;
out vec4 fragColor;
void main() {
    // Simple placeholder for point rendering effect
    // Can be enhanced to sample a texture of point data
    float dist = length(gl_PointCoord - vec2(0.5)) * 2.0;
    fragColor = color * opacity * (1.0 - dist);
}
