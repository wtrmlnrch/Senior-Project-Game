extends Node2D

@onready var tilemap = $ground
@onready var player = $MainCharacter
@onready var camera = $MainCharacter/PlayerCamera

var scene = load("res://newfolder/Scenes/MinimumViableProduct/level0_Snow.tscn")

func _ready():
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	
	camera.limit_left = used_rect.position.x * cell_size.x
	camera.limit_top = used_rect.position.y * cell_size.y
	camera.limit_right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y
	
	player.max_speed = 65
	player.speed = player.max_speed
	camera.zoom = Vector2(2.50, 2.50)


func _on_level_0_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_packed(scene)
