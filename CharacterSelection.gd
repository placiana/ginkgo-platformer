extends Control

func _ready():
	$HBoxContainer/GinkgoOption/Ginkgo.grab_focus()

func _on_ginkgo_pressed():
	GameManager.selected_cat = "ginkgo"
	start_game()

func _on_raul_pressed():
	GameManager.selected_cat = "raul"
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://Main.tscn")
