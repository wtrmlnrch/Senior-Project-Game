extends Node2D

var body_inside = false
var hide_player = false
var my_body

func _on_area_2d_body_entered(body):
	body_inside = true
	my_body = body

func _on_area_2d_body_exited(_body):
	body_inside = false
	
func _process(_delta):
	if body_inside:
		if Input.is_key_pressed(KEY_E):
			hide_player = true
		else:
			hide_player = false
	
	if hide_player and $Area2D.get_overlapping_bodies()[0] == my_body:
		pass # make invisible and make sure can't move
	elif $Area2D.has_overlapping_bodies(): 
		pass # make visible and make sure can move
