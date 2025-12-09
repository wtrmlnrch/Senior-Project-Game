extends Node2D

@onready var camera = $MainCharacter/PlayerCamera

var scene = load("res://newfolder/village.tscn")

var exit_area = false

func _ready():
	camera.limit_left = 775
	camera.limit_right = 765
	camera.limit_top = -45
	camera.limit_bottom = -15
	camera.zoom = Vector2(1.55, 1.55)

func _process(delta: float) -> void:
	if exit_area == true and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_packed(scene)


func _on_exit_body_entered(body: Node2D) -> void:
	exit_area = true


func _on_exit_body_exited(body: Node2D) -> void:
	exit_area = false
