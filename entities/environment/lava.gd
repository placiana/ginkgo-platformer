extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		if get_tree().current_scene.has_method("game_over"):
			get_tree().current_scene.game_over()
