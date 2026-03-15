extends CharacterBody2D
class_name BasePlayer

@export var SPEED = 400.0
@export var ACCELERATION = 1500.0
@export var FRICTION = 1000.0
@export var AIR_RESISTANCE = 400.0
@export var JUMP_VELOCITY = -500.0

# DASH CONSTANTS
@export var DASH_SPEED = 1200.0
@export var DASH_DURATION = 0.2
@export var DASH_COOLDOWN = 0.8

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var camera = $Camera2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

# CAMERA SETTINGS
const CAMERA_LOOK_AHEAD = 180.0
const CAMERA_SMOOTH_SPEED = 2.0

# DASH VARIABLES
var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 1.0

# BORED LOGIC
var inactivity_timer = 0.0
const IDLE_THRESHOLD = 1.0
const BORED_THRESHOLD = 5.0
var is_playing_bored = false

# RAINBOW TRAIL VARIABLES
var ghost_scene_script = preload("res://entities/player/dash_ghost.gd")
var rainbow_shader = preload("res://assets/shaders/rainbow_ghost.gdshader")
var ghost_spawn_timer = 0.0
const GHOST_INTERVAL = 0.04 

# BEAM POWER
var beam_scene = preload("res://entities/player/beam.tscn")
var beam_instance = null
var beam_cooldown = 0.0
const BEAM_COOLDOWN_TIME = 0.6

func _ready():
    # Conectar señal de fin de animación
    animation_player.animation_finished.connect(_on_animation_finished)
    
    # Instanciar el rayo
    beam_instance = beam_scene.instantiate()
    add_child(beam_instance)
    # Posicionar a la altura de la cabeza del gato
    beam_instance.position = Vector2(0, -60)

func _physics_process(delta):
    if is_dashing:
        dash_timer -= delta
        inactivity_timer = 0
        ghost_spawn_timer -= delta
        if ghost_spawn_timer <= 0:
            spawn_rainbow_ghost()
            ghost_spawn_timer = GHOST_INTERVAL
        if dash_timer <= 0:
            is_dashing = false
            velocity.x = dash_direction * SPEED
    
    if dash_cooldown_timer > 0:
        dash_cooldown_timer -= delta
    
    if beam_cooldown > 0:
        beam_cooldown -= delta

    if is_dashing:
        velocity.y = 0
        velocity.x = dash_direction * DASH_SPEED
        if animation_player.has_animation("dash"):
            animation_player.play("dash")
        move_and_slide()
        return

    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        has_double_jumped = false

    if Input.is_action_just_pressed("ui_accept"):
        reset_bored()
        if is_on_floor():
            velocity.y = JUMP_VELOCITY
        elif not has_double_jumped:
            velocity.y = JUMP_VELOCITY
            has_double_jumped = true

    if Input.is_action_just_released("ui_accept") and velocity.y < 0:
        velocity.y *= 0.5

    if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
        reset_bored()
        start_dash()

    var direction = Input.get_axis("ui_left", "ui_right")
    
    if direction != 0:
        reset_bored()
        velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
        sprite.flip_h = direction < 0
        dash_direction = direction
        if is_on_floor():
            animation_player.play("walk")
    else:
        var current_friction = FRICTION if is_on_floor() else AIR_RESISTANCE
        velocity.x = move_toward(velocity.x, 0, current_friction * delta)
        
        if is_on_floor():
            if abs(velocity.x) > 10.0:
                # DESLIZAMIENTO POR INERCIA: Sin animación
                animation_player.stop()
                sprite.frame = 0 
                inactivity_timer = 0
            else:
                # PARADO: Lógica de Idle/Bored
                if not is_playing_bored:
                    inactivity_timer += delta
                    if inactivity_timer >= BORED_THRESHOLD and animation_player.has_animation("bored"):
                        is_playing_bored = true
                        animation_player.play("bored")
                    elif inactivity_timer >= IDLE_THRESHOLD:
                        animation_player.play("idle")
                    else:
                        animation_player.stop()
                        sprite.frame = 0
    
    if not is_on_floor():
        inactivity_timer = 0
        if animation_player.has_animation("jump"):
            animation_player.play("jump")
        else:
            animation_player.stop()
            sprite.frame = 1

    # CONTROL DE CÁMARA (ANTICIPACIÓN)
    if camera:
        var target_offset = dash_direction * CAMERA_LOOK_AHEAD
        var weight = 1.0 - exp(-CAMERA_SMOOTH_SPEED * delta)
        camera.offset.x = lerp(camera.offset.x, target_offset, weight)

    # ATAQUE (BEAM)
    if beam_instance and beam_cooldown <= 0:
        if Input.is_action_just_pressed("attack"):
            beam_instance.activate(dash_direction)
            beam_cooldown = BEAM_COOLDOWN_TIME

    move_and_slide()

func reset_bored():
    inactivity_timer = 0
    is_playing_bored = false

func _on_animation_finished(anim_name):
    if anim_name == "bored":
        reset_bored()

func start_dash():
    is_dashing = true
    dash_timer = DASH_DURATION
    dash_cooldown_timer = DASH_COOLDOWN
    ghost_spawn_timer = 0
    reset_bored()
    
    if velocity.x == 0:
        dash_direction = -1.0 if sprite.flip_h else 1.0
    else:
        dash_direction = 1.0 if velocity.x > 0 else -1.0
    
    if animation_player.has_animation("dash"):
        animation_player.play("dash")
    
    sprite.modulate = Color(2, 2, 2)
    await get_tree().create_timer(DASH_DURATION).timeout
    sprite.modulate = Color(1, 1, 1)

func spawn_rainbow_ghost():
    var ghost = Sprite2D.new()
    ghost.texture = sprite.texture
    ghost.hframes = sprite.hframes
    ghost.vframes = sprite.vframes
    ghost.frame = sprite.frame
    ghost.flip_h = sprite.flip_h
    ghost.global_position = sprite.global_position
    ghost.global_scale = sprite.global_scale
    ghost.set_script(ghost_scene_script)
    var mat = ShaderMaterial.new()
    mat.shader = rainbow_shader
    ghost.material = mat
    get_tree().current_scene.add_child(ghost)

func die():
    sprite.flip_v = true
    set_physics_process(false)
