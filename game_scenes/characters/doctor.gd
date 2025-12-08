extends npc

var player_in_range = false
@export var dialogic_timeline: String = "doctalk"

func _ready():
	npc_name = "Brother Land"
	#$Area2D.area_entered.connect(_on_area_entered)
	#$Area2D.area_exited.connect(_on_area_exited)
	
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		interact()


func _on_area_entered(area):
	player_in_range = true


func _on_area_exited(area):
	player_in_range = false


func interact():
	if player_in_range:
		Dialogic.start(dialogic_timeline)
		special_talk_function()


func special_talk_function():
	pick_inventory_slot('pill')
