extends Control

func _ready():
	$VBoxContainer/NewGame.grab_focus()

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/character_selection.tscn")

func _on_exit_pressed():
	get_tree().quit()
