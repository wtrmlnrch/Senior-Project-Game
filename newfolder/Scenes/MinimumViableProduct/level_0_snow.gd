extends Node2D

@onready var camera = $CharacterBody2D/PlayerCamera
@onready var tilemap = $FloorLayer

# Comment to let me merge

	
func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return
	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('ForestDialogue1')
		get_viewport().set_input_as_handled()
	
		
func _ready():
	Dialogic.start("ForestsDialogue1")
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size

	camera.limit_left = used_rect.position.x * cell_size.x
	camera.limit_top = used_rect.position.y * cell_size.y
	camera.limit_right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y
 
