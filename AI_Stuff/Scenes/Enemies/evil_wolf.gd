extends CharacterBody2D

@export var normalSpeed : int = 150
@export var speed_multiplier = 2
@export var alertDuration = 2.0

var path_waypoints : Array = []
var is_moving_on_path : bool = false
var waypoint_index : int

var alert = false
var alert_timer = 0.0
var target_position = Vector2.ZERO

var squirrel_body = null
var growled = false

@onready var lineOfSight = $RayCast2D
	
func set_path(points: Array):
	path_waypoints = points
	waypoint_index = 0
	is_moving_on_path = true
	
func _process(_delta):
	if get_slide_collision_count() > 0 and get_last_slide_collision().get_collider().is_class("CharacterBody2D"):
		get_tree().reload_current_scene()


func _physics_process(delta):
	if alert:
		alert_timer -= delta
		if alert_timer <= 0:
			alert = false
			growled = false
		
		var direction = (target_position - global_position).normalized()
		velocity = direction * normalSpeed * speed_multiplier
	
		if !growled:
			$Growl.play()
			growled = true
		if $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.pitch_scale = 2
		else:
			$AudioStreamPlayer2D.play()
			$AudioStreamPlayer2D.pitch_scale = 2
		
		move_and_slide()
		
		_play_animation_by_velocity()
		return
	
	if lineOfSight.is_colliding() and lineOfSight.get_collider(0).is_class("CharacterBody2D"):
		alert = true
		alert_timer = alertDuration
		target_position = lineOfSight.get_collider(0).global_position
		
	
	if is_moving_on_path and !path_waypoints.is_empty():
		if waypoint_index < path_waypoints.size():
			var current_target = path_waypoints[waypoint_index]
			
			var direction = (current_target - global_position).normalized()
			velocity = direction * normalSpeed
			
			if $AudioStreamPlayer2D.playing:
				$AudioStreamPlayer2D.pitch_scale = 1
			else:
				$AudioStreamPlayer2D.play()
			
		
			move_and_slide()
			
			if global_position.distance_to(current_target) < 5:			
				waypoint_index += 1
		else:
			is_moving_on_path = false
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
	
	_play_animation_by_velocity()

func moveLeft():
	$"AnimationPlayer".play("Walking Left")

func moveRight():
	$"AnimationPlayer".play("Walking Right")

func moveUp():
	$"AnimationPlayer".play("Walking Up")

func moveDown():
	$"AnimationPlayer".play("Walking Down")
	
func _play_animation_by_velocity():
	if velocity == Vector2.ZERO:
		$AnimationPlayer.play("RESET")
	elif abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			moveRight()
		else:
			moveLeft()
	else:
		if velocity.y > 0:
			moveDown()
		else:
			moveUp()
	


func _on_listening_area_area_entered(body):
	squirrel_body = body.get_parent()
	squirrel_body.sound_emitted.connect(_on_squirrel_sound)
	
func _on_listening_area_area_exited(_body):
	if squirrel_body != null:
		squirrel_body.sound_emitted.disconnect(_on_squirrel_sound)
		squirrel_body = null

func _on_squirrel_sound(sound_position : Vector2):
	alert = true
	alert_timer = alertDuration
	target_position = sound_position
