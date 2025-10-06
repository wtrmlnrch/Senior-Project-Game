extends CharacterBody2D

@export var max_speed: int = 100
var speed: int

#hunger Bar
@export var max_hunger: int = 100
var hunger: float

#hunger losing fullness
@export var hunger_loss: float = 1.0
@export var hunger_bar: TextureProgressBar

# movement and hiding variables
var can_move: bool = true
var can_hide: bool = false
var is_hidden: bool = false

func _ready():
	speed = max_speed
	hunger = max_hunger

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
		check_collision_shape()
		check_z_index()
	
	
	hunger -= hunger_loss * delta
	hunger = clamp(hunger, 0, max_hunger)
	
	
	#print(hunger)
	if hunger_bar:
		hunger_bar.value = hunger
		
	
# check character facing
var is_facing_front: bool = true
var is_facing_back: bool = false
var is_facing_right: bool = false
var is_facing_left: bool = false



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

func check_collision_shape():
	if is_facing_front == true:
		$CollisionWhenForward.disabled = false
		$CollisionWhenBackwards.disabled = true
	else:
		$CollisionWhenForward.disabled = true
		$CollisionWhenBackwards.disabled = false

func check_z_index():
	if is_facing_back == true:
		z_index = 2
	else:
		z_index = 0

func make_invisible():
	$AnimatedSprite2D.visible = false
	can_move = false
	
func make_visible():
	set_collision_mask_value(2, true)
	$AnimatedSprite2D.visible = true
	can_move = true
