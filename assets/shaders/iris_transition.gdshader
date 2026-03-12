shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.5) = 1.0;
uniform vec2 center = vec2(0.5, 0.5);
uniform float aspect_ratio = 1.777777778; // 16:9 por defecto

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 diff = uv - center;
    diff.x *= aspect_ratio;
    
    float dist = length(diff);
    
    if (dist > radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
