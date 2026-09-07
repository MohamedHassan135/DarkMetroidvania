extends Area2D

# Simple attack area used by player — enable briefly to hit enemies
@export var damage: int = 1
@export var active_time: float = 0.12

var timer: float = 0.0
var active: bool = false

func attack(dir: int) -> void:
    # Position relative to player facing
    position = Vector2(18 * dir, 0)
    monitoring = true
    active = true
    timer = active_time
    show()

func _ready() -> void:
    hide()
    connect("body_entered", self, "_on_body_entered")

func _physics_process(delta: float) -> void:
    if active:
        timer -= delta
        if timer <= 0:
            active = false
            monitoring = false
            hide()

func _on_body_entered(body: Node) -> void:
    if body and body.has_method("apply_damage"):
        body.apply_damage(damage)
