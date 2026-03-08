extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if get_tree().current_scene.has_method("game_over"):
			get_tree().current_scene.game_over()
