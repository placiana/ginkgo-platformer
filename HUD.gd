extends Control

@onready var cat_portrait = $MarginContainer/HBoxContainer/Panel/CatPortrait

func _ready():
	var ginkgo_tex = preload("res://ginkgo_hud.svg")
	var raul_tex = preload("res://raul_hud.svg")
	
	if GameManager.selected_cat == "raul":
		cat_portrait.texture = raul_tex
	else:
		cat_portrait.texture = ginkgo_tex
