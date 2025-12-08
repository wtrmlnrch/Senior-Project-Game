extends Node2D

@export var tile_size : int = 64
@export var map_size : int = 35

var walkable = []

func _ready():
	walkable = []
	for y in map_size:
		var row = []
		for x in map_size:
			row.append(true)
		walkable.append(row)

func world_to_grid(world_pos : Vector2) -> Vector2i:
	return Vector2i(int(world_pos.x / tile_size), int(world_pos.y / tile_size))
	
func grid_to_world(grid_pos : Vector2i) -> Vector2:
	return Vector2(grid_pos.x * tile_size + tile_size/2, grid_pos.y * tile_size + tile_size/2)
	
func bfs(start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	if not _in_bounds(start) or not _in_bounds(goal):
		return []

	var queue: Array[Vector2i] = []
	var came_from := {}
	var visited := {}

	queue.append(start)
	visited[start] = true

	var dirs = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)]

	while queue.size() > 0:
		var current: Vector2i = queue.pop_front()
		if current == goal:
			return _reconstruct_path(came_from, start, goal)
		for d in dirs:
			var next = current + d
			if _in_bounds(next) and walkable[next.y][next.x] and not visited.has(next):
				visited[next] = true
				came_from[next] = current
				queue.append(next)
	return []


func _reconstruct_path(came_from: Dictionary, start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	var path: Array[Vector2i] = [goal]
	var curr := goal

	while curr != start:
		curr = came_from[curr]
		path.insert(0, curr)

	return path


func _in_bounds(tile: Vector2i) -> bool:
	return tile.x >= 0 and tile.y >= 0 and tile.x < map_size and tile.y < map_size
