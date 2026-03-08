extends Control

@onready var cat_portrait = $MarginContainer/HBoxContainer/Panel/CatPortrait

func _ready():
	# Usar los nuevos archivos PNG de alta resolución
	var ginkgo_tex = preload("res://selected_character_hud.png")
	var raul_tex = preload("res://selected_character_black_hud.png")
	
	if GameManager.selected_cat == "raul":
		cat_portrait.texture = raul_tex
	else:
		cat_portrait.texture = ginkgo_tex
