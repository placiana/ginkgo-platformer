shader_type canvas_item;

uniform vec4 beam_color : source_color = vec4(0.2, 0.5, 1.0, 1.0);
uniform vec4 edge_color : source_color = vec4(0.0, 0.2, 0.8, 0.0);
uniform float speed = 10.0;
uniform float intensity = 0.7;

void fragment() {
	// UV.y va de 0.0 a 1.0 a lo ancho del Line2D
	float dist_from_center = abs(UV.y - 0.5) * 2.0;
	
	// Crear un degradado suave hacia los bordes
	float alpha_mask = 1.0 - pow(dist_from_center, 4.0);
	
	// Brillo central muy fuerte
	float core_glow = 1.0 - pow(dist_from_center, 2.0);
	
	// Ruido de energía animado
	float energy = sin(UV.x * 30.0 - TIME * speed) * 0.5 + 0.5;
	energy *= sin(UV.x * 15.0 + TIME * speed * 0.7) * 0.5 + 0.5;
	
	// Color final mezclando base y bordes
	vec4 final_color = mix(edge_color, beam_color, core_glow);
	
	// Añadir el "ruido" de energía al brillo
	final_color.rgb += core_glow * energy * intensity;
	
	// Forzar blanco puro en el centro exacto
	float center_line = 1.0 - smoothstep(0.0, 0.15, dist_from_center);
	final_color.rgb += center_line * 0.8;
	
	COLOR = vec4(final_color.rgb, alpha_mask);
}
