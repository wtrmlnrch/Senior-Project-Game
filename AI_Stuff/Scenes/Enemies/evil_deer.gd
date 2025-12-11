extends Node2D

var teleportation_points : Array

var teleportation_cooldown : float = 5.0
var teleportation_time : float = 0.0

var just_tpd : bool = false

signal haunting_cry_entry(player)
signal haunting_cry_exit(player)

func _ready():
	$Body/AnimationPlayer.play("head moving")
	
	for p in $"Teleportation Points".get_children():
		teleportation_points.append(p.global_position)

func teleportation():
	var point : Vector2
	point = teleportation_points.pick_random()
	
	$Body.global_position = point
	just_tpd = true
	
func _process(delta):
	if just_tpd:
		teleportation_time = teleportation_cooldown
	
	if teleportation_time > 0:
		teleportation_time -= delta
		just_tpd = false
	else:
		teleportation()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("haunting_cry_entry", body)
		$Body/AudioStreamPlayer2D.play(0.0)


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		emit_signal("haunting_cry_exit", body)
		$Body/AudioStreamPlayer2D.stop()
