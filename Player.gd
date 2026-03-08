extends CharacterBody2D

const SPEED = 400.0
const ACCELERATION = 1500.0
const FRICTION = 1000.0
const AIR_RESISTANCE = 400.0
const JUMP_VELOCITY = -500.0

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

func _ready():
    # Ignorar selección y usar siempre el sprite sheet 6x1 de 128×128
    sprite.texture = preload("res://cat_walk_sprite_6x1.png")
    sprite.hframes = 6
    sprite.vframes = 1
    sprite.frame = 0

func _readyBak():
    # Si existe un sprite sheet específico en el GameManager, lo cargamos
    if GameManager.selected_cat in GameManager.cat_textures:
        sprite.texture = GameManager.cat_textures[GameManager.selected_cat]

func _physics_process(delta):
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

    # Entrada y movimiento horizontal
    var direction = Input.get_axis("ui_left", "ui_right")
    
    if direction != 0:
        velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
        sprite.flip_h = direction < 0
        # Reproducir caminata si estamos en el suelo
        if is_on_floor():
            animation_player.play("walk")
    else:
        var current_friction = FRICTION if is_on_floor() else AIR_RESISTANCE
        velocity.x = move_toward(velocity.x, 0, current_friction * delta)
        # Reproducir quieto si estamos en el suelo
        if is_on_floor():
            animation_player.play("idle")
    
    # Si estamos saltando, detenemos la animación de caminata
    if not is_on_floor():
        animation_player.stop()
        sprite.frame = 1 # Usar un cuadro de salto

    move_and_slide()

    func die():
    # Girar al gato upside down
    sprite.flip_v = true
    # Opcional: Desactivar colisiones o movimiento si fuera necesario
    set_physics_process(false)

