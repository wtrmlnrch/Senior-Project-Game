extends Node2D

var wolves = []

func _ready() -> void:
	wolves = $Wolves.get_children()

#extends Node2D
#class_name WolfPackAI
#
#@onready var map_grid: MapGrid = $MapGrid
#@onready var wolves_container: Node2D = $Wolves
#@export var patrol_min_dist: int = 12
#@export var player: Node2D
#
#signal pack_alert(player_pos: Vector2)
#
#var wolves: Array = []
#
#
#func _ready():
	## register wolves
	#for w in wolves_container.get_children():
		#wolves.append(w)
		#w.pack = self
		#w.map_grid = map_grid
		#w.player = player
		#w.start_patrol()
#
#
#func get_random_patrol_tile(origin_tile: Vector2i) -> Vector2i:
	#while true:
		#var random := Vector2i(randi_range(0, map_grid.width), randi_range(0, map_grid.height))
		#if origin_tile.distance_to(random) > patrol_min_dist:
			#return random
#
#
#func alert_pack(player_pos: Vector2):
	## signal the pack (individual wolves handle the chase logic)
	#emit_signal("pack_alert", player_pos)
