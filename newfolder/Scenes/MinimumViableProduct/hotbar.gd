extends CanvasLayer

var active_index = -1
var slots = []
var globals_keys = [
	"inventory1active",
	"inventory2active",
	"inventory3active",
	"inventory4active",
	"inventory5active"
]

func _ready():
	slots = [
		$HBoxContainer/InventorySlot,
		$HBoxContainer/InventorySlot2,
		$HBoxContainer/InventorySlot3,
		$HBoxContainer/InventorySlot4,
		$HBoxContainer/InventorySlot5
	]

	for i in range(slots.size()):
		slots[i].toggle_mode = true
		slots[i].pressed.connect(func(): _on_slot_pressed(i))


func _on_slot_pressed(index: int) -> void:
	active_index = index
	for i in range(slots.size()):
		var is_active = (i == index)
		slots[i].button_pressed = is_active
		Globals.set(globals_keys[i], is_active)
