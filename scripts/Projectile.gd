extends Area2D

@export var speed: float = 320.0
@export var damage: int = 1
@export var lifetime: float = 2.0

var velocity := Vector2.ZERO
var timer: float = 0.0

func launch(dir: Vector2) -> void:
    velocity = dir.normalized() * speed
    timer = lifetime
    visible = true
    monitoring = true

func _physics_process(delta: float) -> void:
    if timer > 0:
        timer -= delta
        position += velocity * delta
    else:
        queue_free()

func _on_body_entered(body: Node) -> void:
    if body and body.has_method("apply_damage"):
        body.apply_damage(damage)
        queue_free()

func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))
    visible = false
    monitoring = false

