extends Node

# Small hit stop utility
func hit_stop(duration: float = 0.05) -> void:
    Engine.time_scale = 0.01
    await get_tree().create_timer(duration).timeout
    Engine.time_scale = 1.0
