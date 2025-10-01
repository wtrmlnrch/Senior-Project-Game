extends Node2D

@export var speed = 50
@export var direction = -1

func _physics_process(_delta):
	$Wolf/AnimationPlayer.play("Walking_wolf")
	
	if direction == 1 and $Walls/RightWall.has_overlapping_bodies():
		direction = -1
		$Wolf.scale.x = -1
	elif direction == -1 and $Walls/LeftWall.has_overlapping_bodies():
		direction = 1
		$Wolf.scale.x = -1
	
	# change speed if the wolf sees the player
	if $Wolf/LineOfSight.is_colliding():
		speed = 125
		$Wolf/AnimationPlayer.speed_scale = 2.5
	else:
		speed = 50
		$Wolf/AnimationPlayer.speed_scale = 1
		
	if $Wolf/BackSight.is_colliding():
		direction = direction * -1
		$Wolf.scale.x = -1
	
	
	$Wolf.velocity.x = direction * speed
	if $Wolf.velocity.y != 0:
		$Wolf.velocity.y = 0
	$Wolf.move_and_slide()


# allow wolf to start walking
# check to see if player in front (5-6) or behind (2-3)
# if behind (if location more or less than player)
	# change direction
# speed up and charge towards player
# if player caught: game over (respawn)
