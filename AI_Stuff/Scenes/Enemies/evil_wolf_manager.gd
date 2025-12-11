extends Node2D

var wolves = []

var TILE_SIZE = 64

var astargrid_roam = AStarGrid2D.new()

@onready var regular_tilemap_layer = $MapGrid/Walking

var random_point : Vector2

func _ready() -> void:
	wolves = $Wolves.get_children()
	initialize_roam()

# continuely lets the wolves roam
func _process(_delta):
	for wolf in wolves:
		if !wolf.is_moving_on_path:
			wolf_move(wolf)
	
func initialize_roam():
	# set up the regular grid area
	var used_rect = regular_tilemap_layer.get_used_rect()
	astargrid_roam.region = used_rect
	
	astargrid_roam.cell_size = Vector2(TILE_SIZE, TILE_SIZE)
	astargrid_roam.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid_roam.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astargrid_roam.update()
	
	# removes empty spaces from traversal
	for x in range(used_rect.position.x, used_rect.end.x):
		for y in range(used_rect.position.y, used_rect.end.y):
			var cell_coords = Vector2i(x, y)
			
			if regular_tilemap_layer.get_cell_source_id(cell_coords) == -1:
				astargrid_roam.set_point_solid(cell_coords, true)
			else: 
				astargrid_roam.set_point_solid(cell_coords, false)


# calculates the roaming path using the built in A* grid
func recalculate_roam(enemy_initial_pos) -> PackedVector2Array:
	var path = []
	var floor_tiles = regular_tilemap_layer.get_used_cells()
	random_point = regular_tilemap_layer.map_to_local(floor_tiles.pick_random())
	
	var local_enemy_pos = regular_tilemap_layer.to_local(enemy_initial_pos)
	var starting_cell = regular_tilemap_layer.local_to_map(local_enemy_pos)
	var end_cell = regular_tilemap_layer.local_to_map(random_point)
		
	path = astargrid_roam.get_point_path(starting_cell, end_cell) 
	for i in range(len(path)):
		path[i] = path[i]+Vector2(32,32)
	
	return path


# makes the wolf move using a calculated path
func wolf_move(wolf):
	wolf.set_path(recalculate_roam(wolf.global_position))
