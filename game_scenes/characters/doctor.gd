extends npc
var player_in_range = false
@export var dialogic_timeline: String = "res://Dialogue stuff/doctalk.dtl"

func _ready():
	npc_name = "Dr.Land"
	$"talk-area".body_entered.connect(_on_area_entered)
	$"talk-area".body_exited.connect(_on_area_exited)

func _physics_process(delta):
	velocity = Vector2.ZERO
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
