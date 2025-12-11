extends Node2D

var in_bed = false
signal slept


func _process(delta):
	if in_bed == true && Input.is_action_just_pressed("Interact"):
		sleep()

func sleep():
	emit_signal("slept")
	
	if Globals.is_night == true:
		Globals.day += 1
		Globals.npcs_talked_to_today = [false, false, false, false, false, false, false, false]
		Globals.day_task_complete = [false, false, false]
		Globals.is_night = false
		Globals.all_tasks_day = false
	else:
		Globals.is_night = true
		Globals.night += 1
		Globals.night_task_complete = [false, false, false]
		Globals.all_tasks_night = false

func _on_sleep_area_body_entered(body: Node2D) -> void:
	in_bed = true


func _on_sleep_area_body_exited(body: Node2D) -> void:
	in_bed = false
