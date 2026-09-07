extends CharacterBody2D

# Player controller for DarkMetroidvania — Phase 1 (polished input + virtual joystick support)
# Typed GDScript for Godot 4.7.2

@export var speed: float = 220.0
@export var max_speed: float = 220.0
@export var accel: float = 1400.0
@export var friction: float = 1200.0
@export var gravity: float = 1400.0
@export var jump_velocity: float = -420.0
@export var max_jumps: int = 2
@export var coyote_time: float = 0.12
@export var jump_buffer_time: float = 0.12
@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.16
@export var dash_cooldown: float = 0.7
@export var invincibility_time: float = 0.8

signal attacked
signal died

var velocity: Vector2 = Vector2.ZERO
var jumps_left: int = 0
var facing: int = 1 # 1 = right, -1 = left
var on_ground_last: bool = false
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0
var invincible_timer: float = 0.0

# Virtual input (from mobile joystick). Range -1..1 for horizontal
var virtual_input: float = 0.0

@onready var attack_area: Node = $AttackArea
@onready var visual: Node = $Visual

func _ready() -> void:
    jumps_left = max_jumps

func set_virtual_input(value: float) -> void:
    virtual_input = clamp(value, -1.0, 1.0)

func _physics_process(delta: float) -> void:
    handle_timers(delta)
    var input_dir: float = get_input_direction()
    handle_movement(input_dir, delta)
    handle_jump_input(delta)
    handle_dash(delta)
    handle_gravity(delta)

    # Apply movement
    velocity = move_and_slide(velocity, Vector2.UP)

    # Update facing
    if input_dir != 0:
        facing = sign(input_dir)

    # Visual flip
    visual.scale.x = facing

func get_input_direction() -> float:
    # Prioritize virtual input if significant (mobile)
    if abs(virtual_input) > 0.05:
        return virtual_input
    var left := Input.is_action_pressed("move_left") or Input.is_key_pressed(Key.A)
    var right := Input.is_action_pressed("move_right") or Input.is_key_pressed(Key.D)
    if left and not right:
        return -1.0
    elif right and not left:
        return 1.0
    return 0.0

func handle_movement(dir: float, delta: float) -> void:
    var target = dir * max_speed
    if abs(target - velocity.x) < 1:
        velocity.x = lerp(velocity.x, target, 0.5)
    elif target == 0:
        velocity.x = move_toward(velocity.x, 0, friction * delta)
    else:
        velocity.x = move_toward(velocity.x, target, accel * delta)

func handle_gravity(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        velocity.y = 0 if velocity.y > 0 else velocity.y

func handle_jump_input(delta: float) -> void:
    # Jump buffer
    if Input.is_action_just_pressed("jump") or Input.is_key_pressed(Key.SPACE):
        jump_buffer_timer = jump_buffer_time

    # coyote
    if is_on_floor():
        coyote_timer = coyote_time
        jumps_left = max_jumps
    else:
        coyote_timer = max(0.0, coyote_timer - delta)

    if jump_buffer_timer > 0 and coyote_timer > 0 and jumps_left > 0:
        perform_jump()

func perform_jump() -> void:
    velocity.y = jump_velocity
    jumps_left -= 1
    jump_buffer_timer = 0.0

func handle_dash(delta: float) -> void:
    if dash_cooldown_timer > 0:
        dash_cooldown_timer -= delta
    if dashing:
        dash_timer -= delta
        if dash_timer <= 0:
            dashing = false
    else:
        if (Input.is_action_just_pressed("dash") or Input.is_key_pressed(Key.K)) and dash_cooldown_timer <= 0:
            dashing = true
            dash_timer = dash_duration
            dash_cooldown_timer = dash_cooldown
            var dir = Vector2(facing, 0)
            velocity.x = dir.x * dash_speed
            velocity.y = 0

func handle_timers(delta: float) -> void:
    if jump_buffer_timer > 0:
        jump_buffer_timer = max(0.0, jump_buffer_timer - delta)
    if invincible_timer > 0:
        invincible_timer = max(0.0, invincible_timer - delta)

# Combat
func attack() -> void:
    if attack_area:
        attack_area.attack(facing)
        emit_signal("attacked")

func take_damage(amount: int, source: Node = null) -> void:
    if invincible_timer > 0:
        return
    invincible_timer = invincibility_time
    # Forward to a Health resource if present
    if has_node("Health"):
        var h = get_node("Health")
        if h and h.has_method("apply_damage"):
            h.apply_damage(amount)
    # Basic knockback
    velocity += Vector2(-facing * 120, -100)
    if has_node("Health") and get_node("Health").is_dead():
        emit_signal("died")
