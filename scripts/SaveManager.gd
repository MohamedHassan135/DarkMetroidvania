extends Node

# Very small Save Manager that writes JSON to user://
const SAVE_PATH := "user://savegame.json"

func save_game(data: Dictionary) -> void:
    var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        var json = JSON.stringify(data)
        file.store_string(json)
        file.close()

func load_game() -> Dictionary:
    var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not file:
        return {}
    var raw = file.get_as_text()
    file.close()
    var parsed = JSON.parse_string(raw)
    if parsed.error != OK:
        return {}
    return parsed.result
