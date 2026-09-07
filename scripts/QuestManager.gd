extends Node

# Very small Quest Manager
var quests: Array = []

func add_quest(q: Dictionary) -> void:
    quests.append(q)

func complete_quest(quest_id: String) -> void:
    for q in quests:
        if q.get("id","") == quest_id:
            q["completed"] = true
            # reward handling placeholder
            return

func get_active_quests() -> Array:
    return quests.filter(func(x): return not x.get("completed", false))

