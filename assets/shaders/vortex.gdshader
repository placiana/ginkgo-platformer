shader_type canvas_item;

uniform vec4 color_inner : source_color = vec4(0.2, 0.05, 0.4, 1.0);
uniform vec4 color_outer : source_color = vec4(0.8, 0.2, 1.0, 1.0);
uniform float speed = 2.0;
uniform float vortex_intensity = 5.0;
uniform float glow_intensity = 1.5;

// Función de ruido simple
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
	// Centrar UV y ajustar para que sea un óvalo
	vec2 uv = (UV - 0.5) * 2.0;
	uv.x *= 0.6; // Factor para hacerlo ovalado verticalmente
	
	float dist = length(uv);
	float angle = atan(uv.y, uv.x);
	
	// Crear el efecto de espiral (vortex)
	float spiral = angle + (dist * vortex_intensity) - (TIME * speed);
	
	// Añadir ruido para distorsión "misteriosa"
	float n = noise(vec2(spiral * 2.0, dist * 5.0 - TIME));
	
	// Máscara del óvalo con bordes suaves
	float mask = smoothstep(0.8, 0.2, dist);
	
	// Intensidad del brillo basada en el ruido y la distancia
	float intensity = smoothstep(0.4, 1.0, n * (1.0 - dist) * 2.0);
	intensity *= mask;
	
	// Color final mezclando tonos violetas
	vec4 final_color = mix(color_inner, color_outer, intensity);
	
	// Añadir el brillo (glow)
	final_color.rgb *= glow_intensity + (n * 0.5);
	
	// Alpha basado en la máscara del óvalo
	final_color.a = mask * (intensity + 0.3);
	
	COLOR = final_color;
}
