extends Node

# GameManager autoload (singleton)
# Handles game state, scene transitions, save/load bridge

@onready var save_manager := load("res://scripts/SaveManager.gd").new()

var player_data: Dictionary = {}

func new_game() -> void:
    player_data = {"position": Vector2(128,128), "health": 10, "max_health": 10, "currency": 0, "abilities": []}
    get_tree().change_scene_to_file("res://scenes/Main.tscn")

func continue_game() -> void:
    var data = save_manager.load_game()
    if data.empty():
        new_game()
        return
    player_data = data
    get_tree().change_scene_to_file("res://scenes/Main.tscn")

func save_game() -> void:
    save_manager.save_game(player_data)

func set_player_position(pos: Vector2) -> void:
    player_data.position = pos

func add_currency(amount: int) -> void:
    player_data.currency = int(player_data.get("currency",0)) + amount

