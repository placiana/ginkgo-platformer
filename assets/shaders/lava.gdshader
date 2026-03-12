shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable;
uniform vec4 color_deep : source_color = vec4(0.4, 0.02, 0.0, 1.0);
uniform vec4 color_shallow : source_color = vec4(1.0, 0.4, 0.0, 1.0);
uniform float speed = 0.05;
uniform float distortion = 0.1;

void fragment() {
	// Primera capa de ruido con movimiento
	vec2 uv1 = UV;
	uv1.x += TIME * speed;
	uv1.y += sin(TIME * 0.5) * 0.02;
	float noise1 = texture(noise_texture, uv1).r;
	
	// Segunda capa de ruido para distorsión (más rápida)
	vec2 uv2 = UV * 1.5;
	uv2.x -= TIME * speed * 1.5;
	float noise2 = texture(noise_texture, uv2).r;
	
	// Mezclar ruidos para un efecto caótico
	float final_noise = mix(noise1, noise2, 0.5);
	
	// Aplicar umbrales para crear "manchas" de magma
	float intensity = smoothstep(0.3, 0.8, final_noise);
	
	// Color base mezclado
	vec4 lava_color = mix(color_deep, color_shallow, intensity);
	
	// Añadir un "brillo" en los puntos más calientes
	float glow = smoothstep(0.7, 1.0, final_noise);
	lava_color += glow * vec4(1.0, 0.9, 0.3, 0.0);
	
	COLOR = lava_color;
}
