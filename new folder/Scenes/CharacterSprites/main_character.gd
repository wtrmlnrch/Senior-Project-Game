extends CharacterBody2D

@export var max_speed: int = 200
var speed: int = max_speed

# check character facing
var is_facing_front: bool = true
var is_facing_back: bool = false
var is_facing_right: bool = false
var is_facing_left: bool = false

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	check_input_movement(direction)

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
