// https://www.shadertoy.com/view/XdXXRj
#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 size;
    vec4 color;
    vec4 dark;
    vec4 light;
};

vec3 sphere = vec3(0, 0, 2);
float sphere_size = 1.372;
vec3 light_pos = vec3(-2.0, 2.0, 0.5);

float raySphere(vec3 rpos, vec3 rdir, vec3 sp, float radius, inout vec3 normal) {
    radius = radius * radius;
    float dt = dot(rdir, sp - rpos);
    if (dt < 0.0) return -1.0;

    vec3 tmp = rpos - sp;
    tmp.x = dot(tmp, tmp);
    tmp.x = tmp.x - dt * dt;
    if (tmp.x >= radius) return -1.0;

    dt = dt - sqrt(radius - tmp.x);
    vec3 point = rpos + rdir * dt;
    normal = normalize(point - sp);
    return dt;
}

void main() {
    vec4 sphere_color = color;
    vec3 normal;

    vec2 uv = (2.0 * qt_TexCoord0 - 1.0) * size / min(size.x, size.y);
    uv.x *= size.x / size.y;
    uv.y = -uv.y;
    vec3 ray = vec3(uv.x, uv.y, 1.0);
    ray = normalize(ray);
    FragColor = vec4(0.0);

    float dist = raySphere(vec3(0.0), ray, sphere, sphere_size, normal);

    if (dist > 0.0) {
        vec3 tmp = normalize(light_pos - sphere);
        float u = atan(normal.z, normal.x) / 3.1415 * 2.0 / 5.0;
        float v = asin(normal.y) / 3.1415 * 2.0 + 0.5;
        FragColor = sqrt(vec4(dot(tmp, normal)) * light * sphere_color);
    }
}
