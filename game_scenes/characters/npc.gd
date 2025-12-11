extends CharacterBody2D
class_name npc

# npc code examples
#npc.move(Vector2(1, 0))  # move right
#npc.move(Vector2(0, -1)) # move up
#npc.move(Vector2.ZERO)   # stop

var globals_keys = [
	"inventory1item",
	"inventory2item",
	"inventory3item"
]

@export var max_speed: int = 100
var speed: int
var is_moving: bool = true
var npc_name = "npc"
var player_near = false
var task_item = ""

func ready():
	speed = max_speed

func _process(delta: float) -> void:
	if player_near == true and Input.is_action_just_pressed("Interact"):
		talk()

func _physics_process(delta):
	move_and_slide()


func move(new_pos: Vector2):
	# If new_pos is ZERO, NPC should stop
	if new_pos == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		# Normalize direction so diagonal movement isn't faster
		velocity = new_pos.normalized() * max_speed

	# Play correct animation only when moving
	if velocity != Vector2.ZERO:
		play_animation()
	else:
		$AnimatedSprite2D.play("idle")


func play_animation():
	# Horizontal movement
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			$AnimatedSprite2D.play("walking-right")
		else:
			$AnimatedSprite2D.play("walking-left")

	# Vertical movement
	else:
		if velocity.y > 0:
			$AnimatedSprite2D.play("walking-backward")
		else:
			$AnimatedSprite2D.play("walking-forward")

func talk():
	Globals.is_talking_to_npc = true
	Globals.npc_interacting_with = npc_name
	special_talk_function()


func _on_talkarea_body_entered(body: Node2D) -> void:
	player_near = true

func _on_talkarea_body_exited(body: Node2D) -> void:
	player_near = false

func special_talk_function():
	pass


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

func take_item() -> void:
	var item_taken = false
	for i in range(globals_keys.size()):
		if (Globals.get(globals_keys[i]) == task_item):
			Globals.set(globals_keys[i], "")
			item_taken = true
			Globals.inventory_full = false
			break
