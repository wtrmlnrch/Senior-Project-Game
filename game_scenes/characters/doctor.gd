extends npc


func _ready():
	npc_name = "Dr. Land"

func special_talk_function():
	pick_inventory_slot('pill')
