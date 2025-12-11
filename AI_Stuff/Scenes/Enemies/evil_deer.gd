extends Node2D

var teleportation_points : Array

var teleportation_cooldown : float = 2.0
var teleportation_time : float = 0.0

var just_tpd : bool = false

signal haunting_cry

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
	emit_signal("haunting_cry")
