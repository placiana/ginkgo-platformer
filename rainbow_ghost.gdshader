shader_type canvas_item;

uniform float opacity : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	// Solo aplicamos el efecto donde hay dibujo (alpha > 0)
	if (tex_color.a > 0.0) {
		// Generar colores arcoíris basados en el tiempo y la posición
		float hue = fract(TIME * 2.0 + UV.x);
		vec3 rgb = abs(mod(hue * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0;
		rgb = clamp(rgb, 0.0, 1.0);
		
		COLOR = vec4(rgb, tex_color.a * opacity);
	} else {
		COLOR = tex_color;
	}
}
