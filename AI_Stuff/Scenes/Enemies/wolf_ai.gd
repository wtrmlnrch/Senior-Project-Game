extends Node2D

@export var normal_speed = 125
@export var direction = -1

@export var y_value = 0
@export var left_x = -300
@export var right_x = 300

var alert = false
var alert_timer = 0.0
var alert_duration = 2.0

var target_position = Vector2.ZERO
var squirrel_body = null
var growled = false

func _ready():
	$Wolf.global_position.y = y_value
	$Walls/LeftWall/LW_Collision.global_position.y = y_value
	$Walls/RightWall/RW_Collision.global_position.y = y_value
	$Walls/LeftWall/LW_Collision.global_position.x = left_x
	$Walls/RightWall/RW_Collision.global_position.x = right_x
	$Wolf.global_position.x = (left_x + right_x) / 2.0
	$Wolf/AnimationPlayer.play("Left Walk")

func _physics_process(delta):
	if alert:
		alert_timer -= delta
		
		$Wolf.velocity.x = direction * (normal_speed*2)
		$Wolf.velocity.y = 0
		$Wolf.global_position.y = y_value
		
		# code doesn't work. try to fix in morning
		if !growled:
			$Growl.play()
			growled = true

		$Wolf.move_and_slide()
		
		if alert_timer <= 0:
			alert = false
			growled = false
		return
	
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
				$Wolf/LineOfSight.target_position.x += $Walls/RightWall/RW_Collision.global_position.x - $Wolf/LineOfSight.global_position.x - $Wolf/LineOfSight.target_position.x - $Walls/RightWall/RW_Collision.shape.size.x

	if direction == 1 and $Walls/RightWall.has_overlapping_bodies():
		turn_left()
	elif direction == -1 and $Walls/LeftWall.has_overlapping_bodies():
		turn_right()
		
	# Makes the wolf swiftly turn around if the player is too close, unless they are beyond the bounds of the wolf's roaming
	if $Wolf/BackSight.is_colliding():
		if $Wolf/AnimationPlayer.current_animation == "Left Walk":
			turn_right()
		elif $Wolf/AnimationPlayer.current_animation == "Right Walk":
			turn_left()

	
	if $Wolf.get_slide_collision_count() > 0 and $Wolf.get_last_slide_collision().get_collider().is_class("CharacterBody2D"):
		get_tree().reload_current_scene()
	else:
		$Wolf.velocity.x = direction * speed
		if $Wolf.velocity.y != 0:
			$Wolf.velocity.y = 0
		$Wolf.global_position.y = y_value
		$Wolf.move_and_slide()


func _on_listening_area_area_entered(body):
	squirrel_body = body.get_parent()
	squirrel_body.sound_emitted.connect(_on_squirrel_sound)
	
func _on_listening_area_area_exited(_body):
	if squirrel_body != null:
		squirrel_body.sound_emitted.disconnect(_on_squirrel_sound)
		squirrel_body = null

func _on_squirrel_sound(sound_position: Vector2):
	alert = true
	alert_timer = alert_duration
	
	if sound_position.x < $Wolf.global_position.x and $Wolf/AnimationPlayer.current_animation != "Left Walk":
		turn_left()
	elif sound_position.x > $Wolf.global_position.x and $Wolf/AnimationPlayer.current_animation != "Right Walk":
		turn_right()
		

func turn_left():
	direction = -1
	$Wolf/AnimationPlayer.play("Left Walk")
	$Wolf/LineOfSight.target_position.x = -200
	$Wolf/BackSight.target_position.x = 75
	
func turn_right():
	direction = 1
	$Wolf/AnimationPlayer.play("Right Walk")
	$Wolf/LineOfSight.target_position.x = 200
	$Wolf/BackSight.target_position.x = -75
