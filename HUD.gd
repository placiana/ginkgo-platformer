extends Control

@onready var cat_portrait = $MarginContainer/HBoxContainer/Panel/CatPortrait

func _ready():
	# Usar los nuevos archivos PNG de alta resolución
	var ginkgo_tex = preload("res://selected_character_hud.png")
	var raul_tex = preload("res://selected_character_black_hud.png")
	var steve_tex = preload("res://assets/characters/steve/steve_hud.png")
	
	if GameManager.selected_cat == "raul":
		cat_portrait.texture = raul_tex
	elif GameManager.selected_cat == "steve":
		# Por ahora Steve usa el mismo que Ginkgo o podrías cargar uno específico
		cat_portrait.texture = steve_tex
	else:
		cat_portrait.texture = ginkgo_tex
