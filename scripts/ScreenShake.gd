extends Node

# Simple screen shake helper
var shaker: Camera2D = null
var time_left: float = 0.0
var power: float = 0.0

func start_shake(cam: Camera2D, duration: float = 0.25, magnitude: float = 6.0) -> void:
    shaker = cam
    time_left = duration
    power = magnitude

func _process(delta: float) -> void:
    if time_left > 0 and shaker:
        time_left -= delta
        var offset = Vector2(randf_range(-power, power), randf_range(-power, power))
        shaker.offset = offset
        power = lerp(power, 0, delta * 6)
    elif shaker:
        shaker.offset = Vector2.ZERO
