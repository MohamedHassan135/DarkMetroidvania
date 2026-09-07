extends CanvasLayer

func _ready() -> void:
    $VBox/NewGame.pressed.connect(_on_new)
    $VBox/Continue.pressed.connect(_on_continue)
    $VBox/Quit.pressed.connect(_on_quit)

func _on_new() -> void:
    var gm = get_tree().get_root().find_node("GameManager", true, false)
    if gm:
        gm.new_game()

func _on_continue() -> void:
    var gm = get_tree().get_root().find_node("GameManager", true, false)
    if gm:
        gm.continue_game()

func _on_quit() -> void:
    get_tree().quit()
