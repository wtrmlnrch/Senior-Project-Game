extends Node2D
@onready var camera = $MainCharacter/PlayerCamera
@onready var tilemap = $tilesets/ground
@onready var player = $MainCharacter

var area
var scenes 
var scene = load("res://newfolder/Scenes/MinimumViableProduct/level0_Night.tscn")
var forest = load("res://game_scenes/path_cg_1.tscn")
var river = load("res://game_scenes/river_cg_1.tscn")

func _ready():
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	area = [false, false, false, false, false, false]
	scenes = [
		load("res://game_scenes/interiors/clinicNight.tscn"),
	]
	
	for i in range(area.size()):
		area[i] = false
	
	camera.limit_left = used_rect.position.x * cell_size.x
	camera.limit_top = used_rect.position.y * cell_size.y
	camera.limit_right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y
	
	player.max_speed = 65
	player.speed = player.max_speed
	camera.zoom = Vector2(2.50, 2.50)

func _process(float) -> void:
	if Input.is_action_just_pressed("Interact"):
		for i in range(area.size()):
			if area[i] == true:
				get_tree().change_scene_to_packed(scenes[i])
				return
	

func _on_clinicentrance_body_entered(body: Node2D) -> void:
	area[0] = true


func _on_clinicentrance_body_exited(body: Node2D) -> void:
	area[0] = false


func _on_path_body_entered(body):
	if body == player:
		get_tree().change_scene_to_packed(scene)


func _on_forest_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_packed(forest)


func _on_river_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_packed(river)
