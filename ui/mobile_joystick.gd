extends Control

# Simple touch joystick implementation
@onready var joystick_area := $Joystick
@onready var jump_button := $JumpButton
@onready var attack_button := $AttackButton

var dragging: bool = false
var pointer_id: int = -1
var center: Vector2 = Vector2.ZERO
var radius: float = 80.0

func _ready() -> void:
    joystick_area.mouse_filter = Control.MouseFilterEnum.MOUSE_FILTER_PASS
    joystick_area.connect("gui_input", Callable(self, "_on_joy_input"))
    jump_button.pressed.connect(_on_jump_pressed)
    attack_button.pressed.connect(_on_attack_pressed)
    # Determine center in global coords
    center = joystick_area.get_global_position() + joystick_area.rect_size * 0.5
    radius = min(joystick_area.rect_size.x, joystick_area.rect_size.y) * 0.45

func _on_jump_pressed() -> void:
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.perform_jump()

func _on_attack_pressed() -> void:
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.attack()

func _on_joy_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        var mb := event as InputEventMouseButton
        if mb.pressed:
            dragging = true
            pointer_id = mb.button_index
            _update_virtual(mb.position)
        else:
            dragging = false
            pointer_id = -1
            _release_virtual()
    elif event is InputEventMouseMotion and dragging:
        var mm := event as InputEventMouseMotion
        _update_virtual(mm.position)

func _update_virtual(local_pos: Vector2) -> void:
    # joystick_area local pos -> convert to -1..1
    var rect = joystick_area.get_rect()
    var center_local = rect.size * 0.5
    var delta = local_pos - center_local
    var dir_x = clamp(delta.x / radius, -1.0, 1.0)
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.set_virtual_input(dir_x)

func _release_virtual() -> void:
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.set_virtual_input(0.0)
