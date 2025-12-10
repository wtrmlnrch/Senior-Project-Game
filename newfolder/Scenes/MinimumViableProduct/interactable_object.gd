extends StaticBody2D
class_name InteractableObject

var globals_keys = [
	"inventory1item",
	"inventory2item",
	"inventory3item",
	"inventory4item",
	"inventory5item"
]

var is_near: bool = false
signal isNear
signal isGone
var item_collected = false

func _process(_delta):
		if is_near and Input.is_action_just_pressed("Interact"):
			interact()

func interact():
	print('object')

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_near = true
	isNear.emit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_near = false
	isGone.emit()


func pick_inventory_slot(item: String) -> void:
	var item_added = false
	for i in range(globals_keys.size()):
		if (Globals.get(globals_keys[i]) == ""):
			Globals.set(globals_keys[i], item)
			item_added = true
			print(item + ' added')
			break
	
	if (item_added == false):
		Globals.inventory_full = true
		print('inventory is full')
