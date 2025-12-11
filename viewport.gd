extends Node2D

var scene

func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_packed(scene)
