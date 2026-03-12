extends Node

var selected_cat = "ginkgo"

var cat_scenes = {
	"ginkgo": "res://entities/player/ginkgo.tscn",
	"raul": "res://entities/player/raul.tscn",
	"steve": "res://entities/player/steve.tscn"
}

var cat_textures = {
	"ginkgo": preload("res://assets/ui/cat_player.svg"),
	"raul": preload("res://assets/ui/raul_cat.svg"),
	"steve": preload("res://assets/characters/steve/walk_sprite.png")
}
