shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable;
uniform vec4 color_deep : source_color = vec4(0.4, 0.02, 0.0, 1.0);
uniform vec4 color_shallow : source_color = vec4(1.0, 0.4, 0.0, 1.0);
uniform float speed = 0.05;
uniform float pixel_size : hint_range(1.0, 100.0) = 6.0;
uniform float wave_amplitude = 0.1;
uniform float wave_frequency = 8.0;

void fragment() {
	// 1. PIXELACIÓN DE UVs
	vec2 uv = UV;
	float grid_size = pixel_size * 10.0;
	uv = floor(uv * grid_size) / grid_size;

	// 2. EFECTO DE OLAS (Ondulación vertical en el tope)
	float wave = sin(uv.x * wave_frequency + TIME * 2.5) * wave_amplitude;
	// Multiplicamos por (1.0 - uv.y) para que la ola afecte arriba (y=0) y no abajo (y=1)
	float dist_from_top = uv.y;
	float wave_mask = pow(1.0 - dist_from_top, 2.0);
	uv.y += wave * wave_mask;

	// 3. GENERACIÓN DE RUIDO PIXELADO (Burbujeo)
	vec2 noise_uv = uv;
	noise_uv.x += TIME * speed;
	float noise = texture(noise_texture, noise_uv).r;
	
	// 4. POSTERIZACIÓN DE COLORES (Look de paleta limitada)
	float steps = 3.0;
	float intensity = floor(noise * steps) / steps;
	
	// Mezclar colores base
	vec4 lava_color = mix(color_deep, color_shallow, intensity);
	
	// 5. BORDE ILUMINADO (Highlight en el tope de la ola)
	// Si el píxel está muy cerca del borde superior después de la ola, lo pintamos más claro
	if (uv.y < 0.08) {
		lava_color = mix(lava_color, vec4(1.0, 0.9, 0.5, 1.0), 0.8);
	}
	
	// Recortar lo que se sale del área (transparencia arriba de la ola)
	if (uv.y < 0.0) {
		discard;
	}

	COLOR = lava_color;
}
