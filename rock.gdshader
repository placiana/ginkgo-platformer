shader_type canvas_item;

uniform vec4 color_rock_dark : source_color = vec4(0.3, 0.3, 0.3, 1.0);
uniform vec4 color_rock_light : source_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform float scale = 10.0;
uniform float grain_intensity = 0.1;

// Función de ruido para generar el patrón de roca
float hash(vec2 p) {
	p = fract(p * vec2(123.34, 456.21));
	p += dot(p, p + 45.32);
	return fract(p.x * p.y);
}

// Ruido celular simple para grietas de roca
float voronoi(vec2 x) {
	vec2 n = floor(x);
	vec2 f = fract(x);
	float m = 1.0;
	for(int j=-1; j<=1; j++)
	for(int i=-1; i<=1; i++) {
		vec2 g = vec2(float(i),float(j));
		vec2 o = vec2(hash(n + g));
		vec2 r = g + o - f;
		float d = dot(r,r);
		m = min(m, d);
	}
	return sqrt(m);
}

void fragment() {
	vec2 uv = UV * scale;
	// Ajustar escala según el tamaño del objeto para que no se estire
	uv.x *= (1.0 / SCREEN_PIXEL_SIZE.x) / (1.0 / SCREEN_PIXEL_SIZE.y) * 0.1; 
	
	float n = voronoi(uv);
	
	// Crear variaciones de color
	float rock_pattern = smoothstep(0.0, 0.8, n);
	vec4 base_color = mix(color_rock_dark, color_rock_light, rock_pattern);
	
	// Añadir granulado (grain)
	float grain = (hash(UV + TIME * 0.01) - 0.5) * grain_intensity;
	base_color.rgb += grain;
	
	// Añadir un borde superior más claro (iluminación)
	if (UV.y < 0.1) {
		base_color.rgb += 0.1;
	}
	
	COLOR = base_color;
}
