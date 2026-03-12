extends Node2D

var player # Referencia al jugador que instanciaremos
@onready var platforms_container = $Platforms
@onready var platform_scene = preload("res://entities/environment/platform.tscn")
@onready var moving_platform_scene = preload("res://entities/environment/moving_platform.tscn")
@onready var portal_scene = preload("res://entities/environment/portal.tscn")
@onready var cloud_layer = $ParallaxBackground/Layer1
@onready var transition_layer = $UI/TransitionLayer

const FINISH_LINE_X = 5000.0
const MIN_GAP = 150.0
const MAX_GAP = 380.0 # Basado en la física del jugador para garantizar el salto
const BASE_PLATFORM_WIDTH = 250.0 # Ancho base aproximado de la textura de la plataforma

var viewport_width = 1152
var cloud_speed = 20.0
var is_winning = false

func _ready():
	# INSTANCIAR AL JUGADOR SEGÚN LA ELECCIÓN
	var scene_path = GameManager.cat_scenes[GameManager.selected_cat]
	var player_scene = load(scene_path)
	player = player_scene.instantiate()
	player.position = Vector2(200, 350)
	player.add_to_group("player")
	add_child(player)
	
	setup_level()

func _process(delta):
	cloud_layer.motion_offset.x += cloud_speed * delta
	
	var cam_pos = player.get_node("Camera2D").get_screen_center_position()
	$Lava.global_position.x = cam_pos.x

func setup_level():
	# Limpiar plataformas si hubiera (para restart)
	for child in platforms_container.get_children():
		child.queue_free()
	
	# PLATAFORMA INICIAL GARANTIZADA
	var start_p = platform_scene.instantiate()
	start_p.position = Vector2(200, 450)
	start_p.scale.x = 1.5
	platforms_container.add_child(start_p)
	
	# El borde derecho de la plataforma actual
	var current_right_edge = 200.0 + (BASE_PLATFORM_WIDTH * 1.5 / 2.0)
	
	# Generación RNG Secuencial
	while current_right_edge < FINISH_LINE_X:
		var gap = randf_range(MIN_GAP, MAX_GAP)
		var scale_x = randf_range(0.6, 1.3)
		var platform_width = BASE_PLATFORM_WIDTH * scale_x
		
		# La nueva posición X es el borde derecho anterior + el hueco + la mitad del nuevo ancho
		var new_x = current_right_edge + gap + (platform_width / 2.0)
		var new_y = randf_range(350, 550)
		
		spawn_platform_at(Vector2(new_x, new_y), scale_x)
		
		# Actualizar el borde derecho para la siguiente iteración
		current_right_edge = new_x + (platform_width / 2.0)
	
	# Asegurar una plataforma final sólida para el portal
	var final_gap = randf_range(MIN_GAP, MAX_GAP * 0.8) # Un poco más cerca para el portal
	var final_width = BASE_PLATFORM_WIDTH * 1.5
	var final_x = current_right_edge + final_gap + (final_width / 2.0)
	
	var final_p = platform_scene.instantiate()
	final_p.position = Vector2(final_x, 400)
	final_p.scale.x = 1.5
	platforms_container.add_child(final_p)
	
	# Colocar el portal sobre la plataforma final
	var portal = portal_scene.instantiate()
	portal.position = final_p.position + Vector2(0, -120)
	portal.player_entered.connect(_on_player_won)
	add_child(portal)

func spawn_platform_at(pos: Vector2, scale_x: float):
	var is_moving = randf() < 0.2 
	var p
	if is_moving:
		p = moving_platform_scene.instantiate()
		p.position = pos
		p.move_distance = randf_range(50, 150)
		p.move_speed = randf_range(1.5, 3.0)
	else:
		p = platform_scene.instantiate()
		p.position = pos
	
	p.scale.x = scale_x
	platforms_container.add_child(p)

func _on_player_won():
	if is_winning: return
	is_winning = true
	
	if player.has_method("set_physics_process"):
		player.set_physics_process(false)
	
	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").stop()
	
	var player_screen_pos = player.get_global_transform_with_canvas().origin
	transition_layer.play_iris_out(player_screen_pos)
	await transition_layer.transition_finished
	get_tree().reload_current_scene()

func game_over():
	if is_winning: return
	if player.has_method("die"):
		player.die()
	$UI/GameOver.show_game_over()
