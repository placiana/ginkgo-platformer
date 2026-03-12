extends CanvasLayer

signal transition_finished

@onready var color_rect = $ColorRect
var is_transitioning = false

func _ready():
	color_rect.material.set_shader_parameter("radius", 1.5)
	color_rect.visible = false

func play_iris_out(center_screen_pos: Vector2):
	color_rect.visible = true
	# Convertir posición de pantalla (píxeles) a UV (0.0 - 1.0)
	var viewport_size = get_viewport().get_visible_rect().size
	var uv_center = center_screen_pos / viewport_size
	color_rect.material.set_shader_parameter("center", uv_center)
	color_rect.material.set_shader_parameter("aspect_ratio", viewport_size.x / viewport_size.y)
	
	var tween = create_tween()
	tween.tween_property(color_rect.material, "shader_parameter/radius", 0.0, 1.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	await tween.finished
	transition_finished.emit()
