extends Node2D

@export var normal_speed = 125
@export var direction = -1

@export var y_value = 0
@export var left_x = -300
@export var right_x = 300


func _ready():
	$Wolf.global_position.y = y_value
	$Walls/LeftWall/LW_Collision.global_position.y = y_value
	$Walls/RightWall/RW_Collision.global_position.y = y_value
	$Walls/LeftWall/LW_Collision.global_position.x = left_x
	$Walls/RightWall/RW_Collision.global_position.x = right_x
	$Wolf.global_position.x = (left_x + right_x) / 2.0
	

func _physics_process(_delta):
	$Wolf/AnimationPlayer.play("Walking_wolf")
	var speed = normal_speed
	
	# change speed if the wolf sees the player
	if $Wolf/LineOfSight.is_colliding() and $Wolf/LineOfSight.get_collider(0).is_class("CharacterBody2D"):
		speed = normal_speed*2
		$Wolf/AnimationPlayer.speed_scale = 2.5
	else:
		$Wolf/AnimationPlayer.speed_scale = 1
		
		# Makes sure the lines of sight don't go past the area they're supposed to be roaming
		if $Wolf/LineOfSight.is_colliding():
			if $Wolf/LineOfSight.get_collider(0) == $Walls/LeftWall:
				$Wolf/LineOfSight.target_position.x += ($Walls/LeftWall/LW_Collision.global_position.x - $Wolf/LineOfSight.global_position.x) - $Wolf/LineOfSight.target_position.x + $Walls/LeftWall/LW_Collision.shape.size.x			
			elif $Wolf/LineOfSight.get_collider(0) == $Walls/RightWall:
				$Wolf/LineOfSight.target_position.x -= $Walls/RightWall/RW_Collision.global_position.x - ($Wolf/LineOfSight.global_position.x - $Wolf/LineOfSight.target_position.x) - $Walls/RightWall/RW_Collision.shape.size.x

	if direction == 1 and $Walls/RightWall.has_overlapping_bodies():
		direction = -1
		$Wolf.scale.x = -1
		$Wolf/LineOfSight.target_position.x = -200
	elif direction == -1 and $Walls/LeftWall.has_overlapping_bodies():
		direction = 1
		$Wolf.scale.x = -1
		$Wolf/LineOfSight.target_position.x = -200
		
	# Makes the wolf swiftly turn around if the player is too close, unless they are beyond the bounds of the wolf's roaming
	if $Wolf/BackSight.is_colliding() and ($Wolf/BackSight.get_collider(0).global_position.x >= $Walls/LeftWall/LW_Collision.global_position.x and $Wolf/BackSight.get_collider(0).global_position.x <= $Walls/RightWall/RW_Collision.global_position.x):
		direction *= -1
		$Wolf.scale.x = -1
		$Wolf/LineOfSight.target_position.x = -200
	
	
	$Wolf.velocity.x = direction * speed
	if $Wolf.velocity.y != 0:
		$Wolf.velocity.y = 0
	$Wolf.global_position.y = y_value
	$Wolf.move_and_slide()
