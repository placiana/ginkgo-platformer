shader_type canvas_item;

uniform vec2 offset;
uniform float speed_factor = 0.2;

void fragment() {
	// Desplazamos las UVs basándonos en el offset que pasaremos desde el script
	vec2 shifted_uv = UV;
	shifted_uv.x += offset.x * speed_factor / float(textureSize(TEXTURE, 0).x);
	
	// Usamos la textura con las UVs desplazadas
	COLOR = texture(TEXTURE, shifted_uv);
}
