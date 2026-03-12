extends Control

func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_game_over():
	show()
	$VBoxContainer/Restart.grab_focus()
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")
