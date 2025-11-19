extends Node2D

@onready var camera = $MainCharacter/PlayerCamera

func _ready():
	camera.limit_left = 750
	camera.limit_right = 750
	camera.limit_top = -15
	camera.limit_bottom = -15
