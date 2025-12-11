extends npc
var player_in_range = false
@export var dialogic_timeline: String = "res://Dialogue stuff/bakertalk.dtl"
@export var speak: String = "res://Dialogue stuff/bakertalk2.dtl"

func _ready():
	npc_name = "Sister Betsy"
	$"talk-area".body_entered.connect(_on_area_entered)
	$"talk-area".body_exited.connect(_on_area_exited)
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		interact()
		
func _on_area_entered(body):
	if body.name == "MainCharacter":
		player_in_range = true
		
func _on_area_exited(body):
	if body.name == "MainCharacter":
		player_in_range = false
		
func interact():
	if player_in_range:
		var current_scene = get_tree().current_scene.name
		if current_scene == "Village":
			Dialogic.start("res://Dialogue stuff/bakertalk.dtl")
		elif current_scene == "Village2":
			Dialogic.start(speak)
		else:
			Dialogic.start(dialogic_timeline)  
			
		special_talk_function()
		
func special_talk_function():
	pass
