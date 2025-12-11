extends CharacterBody2D

@export var max_speed: int = 100
var speed: int


@export var hunger_bar: TextureProgressBar
@export var health_bar: TextureProgressBar

# movement and hiding variables
var can_move: bool = true
var can_hide: bool = false
var is_hidden: bool = false

func _ready():
	
	speed = max_speed
	Globals.hunger = Globals.max_hunger
	for deer in get_tree().get_nodes_in_group("deer"):
		deer.haunting_cry_entry.connect(_on_deer_haunting_cry_entry)
		deer.haunting_cry_exit.connect(_on_deer_haunting_cry_exit)

func _process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if can_hide and Input.is_action_just_pressed("Interact"):
		is_hidden = !is_hidden
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		if is_hidden:
			can_move = false
			set_collision_layer_value(1, false)
			set_collision_layer_value(8, true)
		else:
			can_move = true
			set_collision_layer_value(1, true)
			set_collision_layer_value(8, false)
	
	if can_move:
		check_input_movement(direction)
	
	
	Globals.hunger -= Globals.hunger_loss * delta
	Globals.hunger = clamp(Globals.hunger, 0, Globals.max_hunger)
	
	
	#print(hunger)
	if hunger_bar:
		hunger_bar.value = Globals.hunger
		
	
# check character facing
var is_facing_front: bool = true
var is_facing_back: bool = false
var is_facing_right: bool = false
var is_facing_left: bool = false

# for dialogue I think
func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return
	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('dialogueA')
		get_viewport().set_input_as_handled()
	
		


# Handles player movement, plays the correct animation
func check_input_movement(direction):
	#check to see if input is being pressed
	if Input.is_action_pressed("up"):
		# play walking se
		if $WalkingSoundWood.playing == false:
			$WalkingSoundWood.playing = true
		velocity = direction * speed
		move_and_slide()
		$AnimatedSprite2D.play("walkingback")
		# keep track of direction of sprite
		is_facing_back = true
		is_facing_front = false
		is_facing_right = false
		is_facing_left = false
	elif Input.is_action_pressed("down"):
		if $WalkingSoundWood.playing == false:
			$WalkingSoundWood.playing = true
		velocity = direction * speed
		move_and_slide()
		$AnimatedSprite2D.play("walkingfront")
		is_facing_back = false
		is_facing_front = true
		is_facing_right = false
		is_facing_left = false
	elif Input.is_action_pressed("right"):
		if $WalkingSoundWood.playing == false:
			$WalkingSoundWood.playing = true
		velocity = direction * speed
		move_and_slide()
		$AnimatedSprite2D.play("walkingright")
		is_facing_back = false
		is_facing_front = false
		is_facing_right = true
		is_facing_left = false
	elif Input.is_action_pressed("left"):
		if $WalkingSoundWood.playing == false:
			$WalkingSoundWood.playing = true
		velocity = direction * speed
		move_and_slide()
		$AnimatedSprite2D.play("walkingleft")
		is_facing_back = false
		is_facing_front = false
		is_facing_right = false
		is_facing_left = true
	else:
		$AnimatedSprite2D.stop()
		$WalkingSoundWood.playing = false



func make_invisible():
	$AnimatedSprite2D.visible = false
	can_move = false
	
func make_visible():
	set_collision_mask_value(2, true)
	$AnimatedSprite2D.visible = true
	can_move = true

func _on_deer_haunting_cry_entry(player):
	print("test")
	if player == self:
		slow_player()

func _on_deer_haunting_cry_exit(player):
	if player == self:
		speed = max_speed

func slow_player():
	speed = max_speed/2
