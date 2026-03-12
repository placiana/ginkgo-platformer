extends StaticBody2D

@export var move_distance = 150.0 # Cuanto se desplaza hacia arriba y abajo
@export var move_speed = 2.0      # Velocidad de la oscilación

var start_y = 0.0
var time = 0.0

func _ready():
	start_y = global_position.y
	# Offset aleatorio para que no todas se muevan igual
	time = randf_range(0, TAU)

func _physics_process(delta):
	time += delta * move_speed
	# Oscilación suave usando seno
	global_position.y = start_y + sin(time) * move_distance
