extends Node2D

signal sound_emitted(sound_position: Vector2)

@export var horizontal_speed = 200
@export var vertical_speed = 25

@export var running_duration = 1.0

var speed = Vector2()
var running_time = 0.0
var running = false

var waiting_time = 1.0

func _ready():
	$Squirrel/AnimationPlayer.play("Scanning")

func _physics_process(delta):
	if $Squirrel/ShapeCast2D.is_colliding() and $Squirrel/ShapeCast2D.get_collider(0).get_name() == "CharacterBody2D" and !running:
		
		running_time = running_duration
		running = true
		
		var hori_multi = 1
		
		# make the squirrel make a noise then wait and disappear 
		$AudioStreamPlayer2D.play()
		emit_sound()
		
		if $Squirrel/ShapeCast2D.get_collider(0).global_position.x < $Squirrel.global_position.x:
			$Squirrel/AnimationPlayer.play("Running Right")
		else:
			hori_multi = -1
			$Squirrel/AnimationPlayer.play("Running Left")
		speed = Vector2(horizontal_speed*hori_multi, vertical_speed)
	
	if (running_time > 0):
		$Squirrel.velocity = speed
		running_time -= delta
	elif (running == true):
		queue_free()
		
	$Squirrel.move_and_slide()
	
func emit_sound():
	sound_emitted.emit(global_position)
