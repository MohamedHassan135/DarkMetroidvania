extends CanvasLayer

func _ready() -> void:
    $Panel/Resume.pressed.connect(_on_resume)
    $Panel/SaveQuit.pressed.connect(_on_save_quit)

func _on_resume() -> void:
    get_tree().paused = false
    hide()

func _on_save_quit() -> void:
    var gm = get_tree().get_root().find_node("GameManager", true, false)
    if gm:
        gm.save_game()
    get_tree().quit()
