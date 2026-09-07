extends Node

# Simple object pool for projectiles and VFX
@export var prefab: PackedScene
@export var pool_size: int = 12

var pool: Array = []

func _ready() -> void:
    for i in pool_size:
        var inst = prefab.instantiate()
        inst.visible = false
        add_child(inst)
        pool.append(inst)

func spawn(position: Vector2, direction: Vector2 = Vector2.RIGHT) -> Node:
    for obj in pool:
        if not obj.visible:
            obj.global_position = position
            if obj.has_method("launch"):
                obj.launch(direction)
            obj.visible = true
            return obj
    # fallback
    var inst = prefab.instantiate()
    add_child(inst)
    pool.append(inst)
    inst.global_position = position
    if inst.has_method("launch"):
        inst.launch(direction)
    return inst

func reclaim(obj: Node) -> void:
    obj.visible = false

