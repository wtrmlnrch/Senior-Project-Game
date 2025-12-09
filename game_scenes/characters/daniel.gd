extends npc

var player_in_range = false
var dialogue_active = false
@export var dialogic_timeline: String = "res://Assets/NPCS/Villagers/leader/butchertalk.dtl"

func _ready():
	npc_name = "Robert"
	$"talk-area".body_entered.connect(_on_area_entered)
	$"talk-area".body_exited.connect(_on_area_exited)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Interact") and not dialogue_active:
		interact()

func _on_area_entered(body):
	if body.name == "MainCharacter" and body != self:
		player_in_range = true

func _on_area_exited(body):
	if body.name == "MainCharacter" and body != self:
		player_in_range = false

func interact():
	if player_in_range and not dialogue_active:
		dialogue_active = true
		Dialogic.start(dialogic_timeline)
		special_talk_function()

func _on_dialogic_signal(argument: String):
	if argument == "dialogue_end":
		dialogue_active = false

func special_talk_function():
	pass
