extends CharacterBody2D

# Expose velocity for camera lookahead
var velocity: Vector2 setget ,get_velocity

func get_velocity() -> Vector2:
    return self.velocity
