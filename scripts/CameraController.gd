extends Camera2D

@export var smooth_speed: float = 8.0
@export var look_ahead: float = 40.0

var target: Node = null

func _ready() -> void:
    target = get_tree().get_root().find_node("Player", true, false)
    current = true

func _physics_process(delta: float) -> void:
    if not target:
        return
    var desired := target.global_position
    # look ahead based on velocity
    if target.has_method("velocity"):
        var vel = Vector2.ZERO
        if target.get("velocity"):
            vel = target.get("velocity")
        desired += vel.normalized() * look_ahead
    global_position = global_position.linear_interpolate(desired, clamp(1 - pow(0.001, delta * smooth_speed), 0, 1))
