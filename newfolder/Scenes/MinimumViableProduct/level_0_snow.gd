extends Node2D


@onready var tilemap = $FloorLayer
@onready var camera = $MainCharacter/PlayerCamera
@onready var player = $MainCharacter
var scene = load("res://newfolder/village.tscn")
var forest_scene = load("res://newfolder/forest.tscn")
var forest_area = false
# Comment to let me merge

	
func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return
	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('res://Dialogue stuff/miniforest.dtl')
		get_viewport().set_input_as_handled()
	
		
func _ready():
	Dialogic.start("res://Dialogue stuff/miniforest.dtl")
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	camera.limit_left = used_rect.position.x * cell_size.x
	camera.limit_top = used_rect.position.y * cell_size.y
	camera.limit_right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y
	


#func _on_Area2D_body_entered(body: Node2D) -> void:
	#pass


func _on_area_2d_body_entered(body):
	if body == player:
		get_tree().change_scene_to_packed(scene)


func _on_forestentrance_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_packed(forest_scene)


func _on_forestentrance_body_exited(body: Node2D) -> void:
	forest_area = false
