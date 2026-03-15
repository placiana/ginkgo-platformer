extends Control

@onready var content_container = $AnchorCenter/Content
@onready var logo_label = $AnchorCenter/Content/Logo
@onready var subtitle_label = $AnchorCenter/Content/Subtitle

# LOGO 1: BLOCK ART CYAN GRADIENT
const LOGO_1 = "[center][font_size=14]
[color=#00ffff]▄▄▄█████▓ ██▀███   ██▓ ▄▄▄      ▓█████▄     ██▓ ███▄    █  ▄████▄  [/color]
[color=#00e6e6]▓  ██▒ ▓▒▓██ ▒ ██▒▓██▒▒████▄    ▒██▀ ██▌   ▓██▒ ██ ▀█   █ ▒██▀ ▀█  [/color]
[color=#00cccc]▒ ▓██░ ▒░▓██ ░▄█ ▒▒██▒▒██  ▀█▄  ░██   █▌   ▒██▒▓██  ▀█ ██▒▒▓█    ▄ [/color]
[color=#00b3b3]░ ▓██▓ ░ ▒██▀▀█▄  ░██░░██▄▄▄▄██ ░▓█▄   ▌   ░██░▓██▒  ▐▌██▒▒▓▓▄ ▄██▒[/color]
[color=#009999]  ▒██▒ ░ ░██▓ ▒██▒░██░ ▓█   ▓██▒░▒████▓    ░██░▒██░   ▓██░▒ ▓███▀ ░[/color]
[color=#008080]  ▒ ░░   ░ ▒▓ ░▒▓░░▓   ▒▒   ▓▒█░ ▒▒▓  ▒    ░▓  ░ ▒░   ▒ ▒ ░ ░▒ ▒  ░[/color]
[color=#006666]    ░      ░▒ ░ ▒░ ▒ ░  ▒   ▒▒ ░ ░ ▒  ▒     ▒ ░░ ░░   ░ ▒░  ░  ▒   [/color]
[color=#004d4d]  ░        ░░   ░  ▒ ░  ░   ▒    ░ ░  ░     ▒ ░   ░   ░ ░ ░        [/color][/font_size][/center]"

# LOGO 2: HEAVY BLOCK GREEN
const LOGO_2 = "[center][font_size=12]
[color=#00ff00] ▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄  ▄▄▄  ▄▄▄▄▄▄▄  ▄▄▄▄▄▄      ▄▄▄  ▄▄    ▄  ▄▄▄▄▄▄  [/color]
[color=#00ee00]█       ██       ██   ██       ██      █    █   ██  █  █ ██      █ [/color]
[color=#00dd00]█_     _██    ▄  ██   ██   ▄   ██  ▄    █   █   ██   █▄█ ██  ▄▄▄▄█ [/color]
[color=#00cc00]  █   █  █   █▄█ ██   ██  █▄█  ██ █ █   █   █   ██       ██ █      [/color]
[color=#00bb00]  █   █  █    ___██   ██       ██ |_|   █   █   ██  ▄    ██ █▄▄▄▄  [/color]
[color=#00aa00]  █   █  █   █   ██   ██  ▄▄   ██      █    █   ██ █ █   ██      █ [/color]
[color=#009900]  █▄▄▄█  █▄▄▄█   █▄▄▄▄█▄▄█ █▄▄▄█▄▄▄▄▄▄█     █▄▄▄█▄█  █▄▄▄▄█▄▄▄▄▄▄█ [/color][/font_size][/center]"

# LOGO 3: SYNTHWAVE PINK/PURPLE
const LOGO_3 = "[center][font_size=14]
[color=#ff00ff]████████╗██████╗ ██╗ █████╗ ██████╗     ██╗███╗   ██╗ ██████╗ [/color]
[color=#e600e6]╚══██╔══╝██╔══██╗██║██╔══██╗██╔══██╗    ██║████╗  ██║██╔════╝ [/color]
[color=#cc00cc]   ██║   ██████╔╝██║███████║██║  ██║    ██║██╔██╗ ██║██║      [/color]
[color=#b300b3]   ██║   ██╔══██╗██║██╔══██║██║  ██║    ██║██║╚██╗██║██║      [/color]
[color=#990099]   ██║   ██║  ██║██║██║  ██║██████╔╝    ██║██║ ╚████║╚██████╗ [/color]
[color=#800080]   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ [/color][/font_size][/center]"

# LOGO 4: SHADED AMBER
const LOGO_4 = "[center][font_size=12]
[color=#ffbf00]░█▀▀█▀▀░█▀▀█░█▀█░█▀▀█░█▀▀▄░░░░▀█▀░█▀▀▄░█▀▀[/color]
[color=#e6ac00]░░░░█░░░█▄▄▀░░█░░█▄▄█░█░░█░░░░░█░░█░░█░█░░[/color]
[color=#cc9900]░░░░█░░░█░░█░▄█▄░█░░█░█▄▄▀░░░░▄█▄░█░░█░█▄▄[/color][/font_size][/center]"

# LOGO 5: MATRIX SLANTED
const LOGO_5 = "[center][font_size=11]
[color=#00ff41] ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄        ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄ [/color]
[color=#00ee3d]▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ ▐░░░░░░░░░░░▌      ▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌[/color]
[color=#00dd39] ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▐░█▀▀▀▀▀▀▀█░▌       ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀ [/color]
[color=#00cc35]     ▐░▌     ▐░▌       ▐░▌     ▐░▌     ▐░▌       ▐░▌ ▐░▌       ▐░▌           ▐░▌     ▐░▌▐░▌    ▐░▌▐░▌          [/color]
[color=#00bb31]     ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌ ▐░▌       ▐░▌           ▐░▌     ▐░▌ ▐░▌   ▐░▌▐░▌          [/color]
[color=#00aa2d]     ▐░▌     ▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌ ▐░▌       ▐░▌           ▐░▌     ▐░▌  ▐░▌  ▐░▌▐░▌          [/color]
[color=#009929]     ▐░▌     ▐░█▀▀▀▀█░█▀▀      ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌ ▐░▌       ▐░▌           ▐░▌     ▐░▌   ▐░▌ ▐░▌▐░▌          [/color]
[color=#008825]     ▐░▌     ▐░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌ ▐░▌       ▐░▌           ▐░▌     ▐░▌    ▐░▌▐░▌▐░▌          [/color]
[color=#007721]     ▐░▌     ▐░▌      ▐░█▄▄    ▐░█▄▄▄  ▐░▌       ▐░▌ ▐░█▄▄▄▄▄▄▄█░▌       ▄▄▄▄█░█▄▄▄▄ ▐░▌     ▐░▐░▌▐░█▄▄▄▄▄▄▄▄▄ [/color]
[color=#00661d]     ▐░▌     ▐░▌       ▐░░░▌   ▐░░░░░▌ ▐░▌       ▐░▌ ▐░░░░░░░░░░░▌      ▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌[/color]
[color=#00661d]      ▀       ▀         ▀▀▀     ▀▀▀▀▀   ▀         ▀   ▀▀▀▀▀▀▀▀▀▀▀        ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀ [/color][/font_size][/center]"

func _ready():
    # Seleccionar logo aleatorio
    var logos = [LOGO_1, LOGO_2, LOGO_3, LOGO_4, LOGO_5]
    var selected_logo = logos[randi() % logos.size()]
    
    logo_label.text = selected_logo
    subtitle_label.text = "[center][font_size=18][color=gray][pulse freq=1.2 color=#ffffff44]TRIAD INC. PRESENTS[/pulse][/color][/font_size][/center]"
    
    # Obtener el centro real después de que el motor procese el layout (una frame después)
    await get_tree().process_frame
    
    # Iniciar centrado y desplazado hacia arriba
    content_container.modulate.a = 0
    var final_y = content_container.position.y
    content_container.position.y -= 200
    
    # Secuencia de animación
    var tween = create_tween()
    
    # 1. Scroll y Aparecer
    tween.tween_property(content_container, "position:y", final_y, 1.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
    tween.parallel().tween_property(content_container, "modulate:a", 1.0, 1.0)
    
    # 2. Esperar
    tween.tween_interval(2.5)
    
    # 3. Desvanecer (Fade Out)
    tween.tween_property(self, "modulate:a", 0.0, 1.0)
    
    # 4. Cambiar de escena
    tween.tween_callback(_on_animation_finished)

func _on_animation_finished():
    get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

func _input(event):
    # Saltar splash con cualquier tecla
    if event is InputEventKey or event is InputEventMouseButton:
        if event.pressed:
            _on_animation_finished()
