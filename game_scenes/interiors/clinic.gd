extends Node2D

@onready var camera = $MainCharacter/PlayerCamera
@onready var doctor = $Doctor

var scene = load("res://newfolder/village.tscn")

func _ready():	
	Dialogic.start("waking")
	camera.limit_left = 750
	camera.limit_right = 750
	camera.limit_top = -15
	camera.limit_bottom = -15
	



func _on_exit_body_entered(body: Node2D) -> void:
	print("Triggered by:", body.name)
	get_tree().change_scene_to_packed(scene)
