extends Node2D

var player # Referencia al jugador que instanciaremos
@onready var platforms_container = $Platforms
@onready var platform_scene = preload("res://Platform.tscn")
@onready var moving_platform_scene = preload("res://MovingPlatform.tscn")
@onready var cloud_layer = $ParallaxBackground/Layer1

var last_gen_x = 1152 
var platform_spacing = 400
var viewport_width = 1152
var cloud_speed = 20.0

func _ready():
	# INSTANCIAR AL JUGADOR SEGÚN LA ELECCIÓN
	var scene_path = GameManager.cat_scenes[GameManager.selected_cat]
	var player_scene = load(scene_path)
	player = player_scene.instantiate()
	player.position = Vector2(200, 300)
	add_child(player)
	
	for i in range(1, 5):
		spawn_platform(i * platform_spacing)

func _process(delta):
	cloud_layer.motion_offset.x += cloud_speed * delta
	
	if player.global_position.x + viewport_width > last_gen_x:
		spawn_platform(last_gen_x)
		last_gen_x += platform_spacing
	
	var cam_pos = player.get_node("Camera2D").get_screen_center_position()
	$Lava.global_position.x = cam_pos.x

func spawn_platform(x_pos):
	var is_moving = randf() < 0.2 
	var p
	if is_moving:
		p = moving_platform_scene.instantiate()
		var y_pos = randf_range(400, 500)
		p.position = Vector2(x_pos, y_pos)
		p.move_distance = randf_range(50, 150)
		p.move_speed = randf_range(1.5, 3.0)
	else:
		p = platform_scene.instantiate()
		var y_pos = randf_range(350, 550)
		p.position = Vector2(x_pos, y_pos)
	
	p.scale.x = randf_range(0.5, 1.2)
	platforms_container.add_child(p)

func game_over():
	if player.has_method("die"):
		player.die()
	$UI/GameOver.show_game_over()
