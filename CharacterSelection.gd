extends Control

func _ready():
	$HBoxContainer/GinkgoOption/Ginkgo.grab_focus()
	# Connect image clicks
	$HBoxContainer/GinkgoOption/TextureRect.gui_input.connect(_on_ginkgo_image_input)
	$HBoxContainer/RaulOption/TextureRect.gui_input.connect(_on_raul_image_input)
	$HBoxContainer/SteveOption/TextureRect.gui_input.connect(_on_steve_image_input)

func _on_ginkgo_image_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_ginkgo_pressed()

func _on_raul_image_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_raul_pressed()

func _on_steve_image_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_steve_pressed()

func _on_ginkgo_pressed():
	GameManager.selected_cat = "ginkgo"
	start_game()

func _on_raul_pressed():
	GameManager.selected_cat = "raul"
	start_game()

func _on_steve_pressed():
	GameManager.selected_cat = "steve"
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://Main.tscn")
