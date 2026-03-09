extends Node

var selected_cat = "ginkgo"

var cat_scenes = {
	"ginkgo": "res://Ginkgo.tscn",
	"raul": "res://Raul.tscn",
	"steve": "res://Steve.tscn"
}

var cat_textures = {
	"ginkgo": preload("res://cat_player.svg"),
	"raul": preload("res://raul_cat.svg"),
	"steve": preload("res://assets/characters/steve/walk_sprite.png")
}
