extends Node2D

# Simple procedural visual for the player (placeholder)
@export var color: Color = Color8(200,180,120)
@export var size: Vector2 = Vector2(16,28)

func _draw() -> void:
    draw_rect(Rect2(-size/2, size), color)
    # simple eye
    draw_circle(Vector2(size.x*0.15, -size.y*0.15), 2, Color.black)

func _ready() -> void:
    update()
