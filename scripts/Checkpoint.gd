extends Node

# Simple checkpoint that tells GameManager to update player position
@export var id: String = "checkpoint_01"

func _on_body_entered(body: Node) -> void:
    if body.name == "Player":
        var gm = get_tree().get_root().find_node("GameManager", true, false)
        if gm:
            gm.set_player_position(body.global_position)

func _ready() -> void:
    if has_node("CollisionShape2D"):
        $CollisionShape2D.connect("body_entered", Callable(self, "_on_body_entered"))
