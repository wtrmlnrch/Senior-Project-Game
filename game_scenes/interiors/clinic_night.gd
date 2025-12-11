extends Node2D

@onready var camera = $MainCharacter/PlayerCamera
@onready var doctor = $Doctor
var scene = load("res://newfolder/village.tscn")
var clinic_day = load("res://game_scenes/interiors/clinic2.tscn")

func _ready():	
	if Globals.night == 1:
		scene = load("res://newfolder/villageNight.tscn")
	elif Globals.night == 2:
		scene = load("res://newfolder/villageNight2.tscn")
	else:
		scene = load("res://newfolder/finalnight.tscn")
	camera.limit_left = 750
	camera.limit_right = 750
	camera.limit_top = -15
	camera.limit_bottom = -15
	
func _on_exit_body_entered(body: Node2D) -> void:
	print("Triggered by:", body.name)
	get_tree().change_scene_to_packed(scene)


func _on_bed_slept() -> void:
	get_tree().change_scene_to_packed(clinic_day)
