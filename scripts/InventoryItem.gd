extends Resource
class_name InventoryItem

@export var id: String = ""
@export var name: String = "Item"
@export var description: String = ""
@export var icon: Texture2D
@export var stackable: bool = true
@export var max_stack: int = 99
@export var is_key_item: bool = false
@export var data: Dictionary = {}
