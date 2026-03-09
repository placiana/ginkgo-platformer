extends CharacterBody2D

const SPEED = 400.0
const ACCELERATION = 1500.0
const FRICTION = 1000.0
const AIR_RESISTANCE = 400.0
const JUMP_VELOCITY = -500.0

# DASH CONSTANTS
const DASH_SPEED = 1200.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 0.8

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

# DASH VARIABLES
var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 1.0

func _ready():
	sprite.texture = preload("res://cat_walk_sprite_6x1.png")
	sprite.hframes = 6
	sprite.vframes = 1
	sprite.frame = 0

func _physics_process(delta):
	# Manejar Timers
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			velocity.x = dash_direction * SPEED # Mantener un poco de inercia
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Si estamos dasheando, la gravedad no nos afecta y la velocidad es fija
	if is_dashing:
		velocity.y = 0
		velocity.x = dash_direction * DASH_SPEED
		move_and_slide()
		return

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Salto
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not has_double_jumped:
			velocity.y = JUMP_VELOCITY
			has_double_jumped = true

	# DASH INPUT
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		start_dash()

	# Entrada y movimiento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		sprite.flip_h = direction < 0
		# Guardar dirección para el dash (hacia donde mira el gato)
		dash_direction = direction
		if is_on_floor():
			animation_player.play("walk")
	else:
		var current_friction = FRICTION if is_on_floor() else AIR_RESISTANCE
		velocity.x = move_toward(velocity.x, 0, current_friction * delta)
		if is_on_floor():
			animation_player.play("idle")
	
	if not is_on_floor():
		animation_player.stop()
		sprite.frame = 1

	move_and_slide()

func start_dash():
	is_dashing = true
	dash_timer = DASH_DURATION
	dash_cooldown_timer = DASH_COOLDOWN
	# Si no hay dirección (quieto), dash hacia donde mira
	if velocity.x == 0:
		dash_direction = -1.0 if sprite.flip_h else 1.0
	else:
		dash_direction = 1.0 if velocity.x > 0 else -1.0
	
	# Efecto visual rápido (puedes añadir partículas aquí luego)
	sprite.modulate = Color(2, 2, 2) # Brillo blanco para el dash
	await get_tree().create_timer(DASH_DURATION).timeout
	sprite.modulate = Color(1, 1, 1) # Volver a la normalidad

func die():
	sprite.flip_v = true
	set_physics_process(false)
