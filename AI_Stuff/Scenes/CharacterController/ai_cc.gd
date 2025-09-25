extends CharacterBody2D

@export var speed = 100

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if velocity:
		$AnimationPlayer.play("Walking")
	else:
		$AnimationPlayer.stop()
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
