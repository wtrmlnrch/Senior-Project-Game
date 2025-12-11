extends Node2D
@onready var camera = $MainCharacter/PlayerCamera
@onready var tilemap = $tilesets/ground
@onready var player = $MainCharacter
@onready var ui = $UI

var area
var scenes 
var scene = load("res://newfolder/Scenes/MinimumViableProduct/level0_Snow.tscn")
var in_forest = false

func _ready():
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	area = [false, false, false, false, false, false]
	scenes = [
		load("res://game_scenes/interiors/clinic.tscn"),
		load("res://game_scenes/interiors/robert_house.tscn"),
		load("res://game_scenes/interiors/baker_house.tscn"),
		load("res://game_scenes/interiors/garroth_house.tscn"),
		load("res://game_scenes/interiors/leader_house.tscn"),
		load("res://game_scenes/interiors/butcher_house.tscn")
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
	$UI/corner/to_enter.visible = true


func _on_clinicentrance_body_exited(body: Node2D) -> void:
	area[0] = false
	$UI/corner/to_enter.visible = false


func _on_robertentrance_body_entered(body: Node2D) -> void:
	area[1] = true
	$UI/corner/to_enter.visible = true


func _on_robertentrance_body_exited(body: Node2D) -> void:
	area[1] = false
	$UI/corner/to_enter.visible = false


func _on_bakerentrance_body_entered(body: Node2D) -> void:
	area[2] = true
	$UI/corner/to_enter.visible = true


func _on_bakerentrance_body_exited(body: Node2D) -> void:
	area[2] = false
	$UI/corner/to_enter.visible = false


func _on_garrothentrance_body_entered(body: Node2D) -> void:
	area[3] = true
	$UI/corner/to_enter.visible = true


func _on_garrothentrance_body_exited(body: Node2D) -> void:
	area[3] = false
	$UI/corner/to_enter.visible = false


func _on_leaderentrance_body_entered(body: Node2D) -> void:
	area[4] = true
	$UI/corner/to_enter.visible = true


func _on_leaderentrance_body_exited(body: Node2D) -> void:
	area[4] = false
	$UI/corner/to_enter.visible = false


func _on_butcherentrance_body_entered(body: Node2D) -> void:
	area[5] = true
	$UI/corner/to_enter.visible = true


func _on_butcherentrance_body_exited(body: Node2D) -> void:
	area[5] = false
	$UI/corner/to_enter.visible = false


func _on_path_body_entered(body):
	if body == player:
		get_tree().change_scene_to_packed(scene)


func _on_forest_body_entered(body: Node2D) -> void:
	pass


func _on_forest_body_exited(body: Node2D) -> void:
	in_forest = false
