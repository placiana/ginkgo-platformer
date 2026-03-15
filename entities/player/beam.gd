extends Node2D

@onready var line = $Line2D
@onready var ray = $RayCast2D

@export var max_length = 800.0
@export var beam_width = 60.0
@export var duration = 0.4 # Segundos (400ms)

var current_direction = 1.0
var is_active = false

func _ready():
	set_process(false)
	line.width = 0.0
	line.points = [Vector2.ZERO, Vector2.ZERO]
	visible = false

func activate(direction: float):
	if is_active: return
	
	is_active = true
	current_direction = direction
	visible = true
	set_process(true)
	
	# Animación de pulso (ancho del rayo)
	var tween = create_tween()
	# Crecer rápido
	tween.tween_property(line, "width", beam_width, duration * 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# Mantener y desvanecer
	tween.tween_property(line, "width", 0.0, duration * 0.8).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(deactivate)

func deactivate():
	is_active = false
	visible = false
	set_process(false)
	line.width = 0.0

func _process(_delta):
	# Orientar el RayCast constantemente por si el jugador se mueve
	ray.target_position = Vector2(max_length * current_direction, 0)
	ray.force_raycast_update()
	
	var end_point = Vector2(max_length * current_direction, 0)
	
	if ray.is_colliding():
		var collision_point = ray.get_collision_point()
		end_point = to_local(collision_point)
	
	# Actualizar el punto final visual
	line.points[1] = end_point
