extends Node2D

@onready var player = $Player
@onready var platforms_container = $Platforms
@onready var platform_scene = preload("res://Platform.tscn")
@onready var bg_texture_rect = $Background/TextureRect

var last_gen_x = 1152 
var platform_spacing = 400
var viewport_width = 1152

func _ready():
	for i in range(1, 5):
		spawn_platform(i * platform_spacing)

func _process(_delta):
	# Generación de plataformas
	if player.global_position.x + viewport_width > last_gen_x:
		spawn_platform(last_gen_x)
		last_gen_x += platform_spacing
	
	# Obtener posición de la cámara
	var cam_pos = player.get_node("Camera2D").get_screen_center_position()
	
	# La lava sigue a la cámara (su posición X)
	$Lava.global_position.x = cam_pos.x
	
	# PASAR OFFSET AL SHADER DE FONDO
	if bg_texture_rect.material:
		bg_texture_rect.material.set_shader_parameter("offset", Vector2(cam_pos.x, 0))

func spawn_platform(x_pos):
	var p = platform_scene.instantiate()
	# Variar altura aleatoriamente (ajustado para plataformas más altas)
	var y_pos = randf_range(350, 550)
	p.position = Vector2(x_pos, y_pos)
	# Variar escala horizontal (mínimo 200px para que se vean bien los bordes)
	p.scale.x = randf_range(0.5, 1.2)
	platforms_container.add_child(p)

func game_over():
	player.die()
	$UI/GameOver.show_game_over()
