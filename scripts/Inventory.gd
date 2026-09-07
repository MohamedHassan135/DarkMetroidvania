extends Node

# Simple inventory manager using resources
@export var capacity: int = 32
var items: Array = [] # array of dictionaries {item:InventoryItem, count:int}

func add_item(item: Resource, count: int = 1) -> bool:
    for entry in items:
        if entry.item.id == item.id and entry.item.stackable:
            entry.count = min(entry.count + count, entry.item.max_stack)
            return true
    if items.size() < capacity:
        items.append({"item": item, "count": count})
        return true
    return false

func remove_item(item_id: String, count: int = 1) -> bool:
    for i in range(items.size()):
        var entry = items[i]
        if entry.item.id == item_id:
            entry.count -= count
            if entry.count <= 0:
                items.remove_at(i)
            return true
    return false

func has_item(item_id: String) -> bool:
    for entry in items:
        if entry.item.id == item_id:
            return true
    return false

