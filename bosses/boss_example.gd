extends CharacterBody2D

# Very small boss example with phases
@export var max_health: int = 60
var health: int = 60
var phase: int = 1

func _ready() -> void:
    health = max_health

func apply_damage(amount: int) -> void:
    health -= amount
    if health <= int(max_health * 0.6) and phase == 1:
        phase = 2
        _enter_phase(2)
    elif health <= int(max_health * 0.3) and phase == 2:
        phase = 3
        _enter_phase(3)
    if health <= 0:
        queue_free()

func _enter_phase(p: int) -> void:
    # Change behavior based on phase (placeholder)
    if p == 2:
        $CollisionShape2D.scale = Vector2.ONE * 1.1
    elif p == 3:
        $CollisionShape2D.scale = Vector2.ONE * 1.3
