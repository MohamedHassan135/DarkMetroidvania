extends Node

# Generic health component
@export var max_health: int = 10
var current_health: int = 10
var dead: bool = false

signal died

func _ready() -> void:
    current_health = max_health

func apply_damage(amount: int) -> void:
    if dead:
        return
    current_health -= amount
    if current_health <= 0:
        current_health = 0
        dead = true
        emit_signal("died")

func is_dead() -> bool:
    return dead

func heal(amount: int) -> void:
    current_health = min(max_health, current_health + amount)
