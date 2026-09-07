extends Control

# Very simple touch joystick placeholder
@onready var joystick_area := $Joystick

func _ready() -> void:
    joystick_area.connect("gui_input", Callable(self, "_on_joy_input"))
    $JumpButton.pressed.connect(_on_jump_pressed)
    $AttackButton.pressed.connect(_on_attack_pressed)

func _on_jump_pressed() -> void:
    # Send jump to player
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.perform_jump()

func _on_attack_pressed() -> void:
    var player = get_tree().get_root().find_node("Player", true, false)
    if player:
        player.attack()

func _on_joy_input(event: InputEvent) -> void:
    # Placeholder: future improvement maps to movement
    pass
