extends Sprite2D

func _ready():
	# Crear un tween para desvanecer el fantasma
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	tween.tween_callback(queue_free)
