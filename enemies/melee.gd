extends CharacterBody2D

# Simple melee enemy with patrol and chase
@export var patrol_left: Vector2 = Vector2(-80,0)
@export var patrol_right: Vector2 = Vector2(80,0)
@export var speed: float = 80.0
@export var detect_range: float = 160.0
@export var attack_range: float = 18.0
@export var damage: int = 1

var origin: Vector2
var target_pos: Vector2
var state: String = "patrol"

func _ready() -> void:
    origin = global_position
    target_pos = origin + patrol_right

func _physics_process(delta: float) -> void:
    var player = get_tree().get_root().get_node_or_null("/root/Node2D/Main/Player")
    var direction = 0
    if player:
        var dist = player.global_position.distance_to(global_position)
        if dist < detect_range:
            state = "chase"
        elif state == "chase" and dist > detect_range * 1.2:
            state = "patrol"

    if state == "patrol":
        var dir = sign(target_pos.x - global_position.x)
        velocity.x = dir * speed
        if (dir > 0 and global_position.x >= target_pos.x) or (dir < 0 and global_position.x <= target_pos.x):
            if target_pos == origin + patrol_right:
                target_pos = origin + patrol_left
            else:
                target_pos = origin + patrol_right
    elif state == "chase" and player:
        var dir = sign(player.global_position.x - global_position.x)
        velocity.x = dir * speed * 1.2
        if global_position.distance_to(player.global_position) < attack_range:
            if player.has_method("take_damage"):
                player.take_damage(damage, self)
    velocity = move_and_slide(velocity, Vector2.UP)
