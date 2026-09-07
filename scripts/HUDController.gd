extends Node

# Connects HUD labels to player health and currency
@onready var health_label: Label = $HealthLabel
@onready var currency_label: Label = $CurrencyLabel

func _process(delta: float) -> void:
    var player = get_tree().get_root().find_node("Player", true, false)
    if player and player.has_node("Health"):
        var h = player.get_node("Health")
        if h and h.has_method("is_dead"):
            health_label.text = "HP: %d" % h.current_health if h.has_variable("current_health") else "HP: ?"
    var gm = get_tree().get_root().find_node("GameManager", true, false)
    if gm:
        var cur = gm.player_data.get("currency", 0)
        currency_label.text = "Gold: %d" % cur
