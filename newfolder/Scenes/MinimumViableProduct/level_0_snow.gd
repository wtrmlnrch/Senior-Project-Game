extends Node2D

@onready var camera = $CharacterBody2D/PlayerCamera
@onready var tilemap = $FloorLayer

# Comment to let me merge

func _ready():
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size

	camera.limit_left = used_rect.position.x * cell_size.x
	camera.limit_top = used_rect.position.y * cell_size.y
	camera.limit_right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	camera.limit_bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y
 
