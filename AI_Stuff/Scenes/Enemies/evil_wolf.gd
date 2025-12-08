extends Node2D

@export var normalSpeed : int = 125
var state = ["PATROL", "SPOTTED", "IDLE", "HOWLING", "CHASE"]
var current_target : Vector2


func _ready():
	pass
	
func moveLeft():
	$"Evil Wolf/AnimationPlayer".play("Walking Left")

func moveRight():
	$"Evil Wolf/AnimationPlayer".play("Walking Right")

func moveUp():
	$"Evil Wolf/AnimationPlayer".play("Walking Up")

func moveDown():
	$"Evil Wolf/AnimationPlayer".play("Walking Down")


#extends CharacterBody2D
#class_name EvilWolf
#
#@export_enum("UP","DOWN","LEFT","RIGHT") var movement_axis := "UP"
#@export var walk_speed: float = 70.0
#@export var chase_speed: float = 140.0
#
#var state := "PATROL"
#var map_grid: MapGrid
#var pack: WolfPackAI
#var player: Node2D
#
#var path: Array[Vector2i] = []
#var path_index: int = 0
#
#@onready var idle_timer: Timer = $IdleTimer
#@onready var detection_area: Area2D = $DetectionArea
#
#
#func _ready():
	#detection_area.body_entered.connect(_on_body_entered)
	#pack.pack_alert.connect(_on_pack_alert)
#
#
#func start_patrol():
	#state = "PATROL"
	#_new_patrol_target()
#
#
#func _new_patrol_target():
	#var grid_pos := map_grid.world_to_grid(global_position)
	#var target_tile: Vector2i = pack.get_random_patrol_tile(grid_pos)
	#path = map_grid.bfs(grid_pos, target_tile)
	#path_index = 0
#
#
#func _physics_process(delta: float):
	#match state:
		#"PATROL":
			#_follow_path(delta, walk_speed)
		#"IDLE":
			## do nothing
			#pass
		#"HOWLING":
			## could play animation
			#pass
		#"CHASE":
			#_chase_player(delta)
#
#
#func _follow_path(delta: float, speed: float):
	#if path.is_empty():
		#idle_timer.start(randf_range(1.0, 3.0))
		#state = "IDLE"
		#return
#
	#if path_index >= path.size():
		#idle_timer.start(randf_range(1.0, 3.0))
		#state = "IDLE"
		#return
#
	#var tile: Vector2i = path[path_index]
	#var world_target := map_grid.grid_to_world(tile)
#
	#var dir := (world_target - global_position).normalized()
#
	## axis restriction
	#match movement_axis:
		#"UP":
			#dir.x = 0
			#dir.y = min(dir.y, 0)   # only upward
		#"DOWN":
			#dir.x = 0
			#dir.y = max(dir.y, 0)
		#"LEFT":
			#dir.y = 0
			#dir.x = min(dir.x, 0)
		#"RIGHT":
			#dir.y = 0
			#dir.x = max(dir.x, 0)
#
	#velocity = dir * speed
	#move_and_slide()
#
	#if global_position.distance_to(world_target) < 5.0:
		#path_index += 1
#
#
#func _on_body_entered(body):
	#if body == player:
		#state = "HOWLING"
#
		## wolf becomes the "caller"
		#pack.alert_pack(player.global_position)
#
		## after howl, chase personally
		#state = "CHASE"
#
#
#func _on_pack_alert(player_pos: Vector2):
	#if state != "CHASE":
		#state = "CHASE"
#
#
#func _chase_player(delta: float):
	#var start_tile = map_grid.world_to_grid(global_position)
	#var player_tile = map_grid.world_to_grid(player.global_position)
#
	#path = map_grid.bfs(start_tile, player_tile)
	#path_index = 0
#
	#_follow_path(delta, chase_speed)
#
#
#func _on_IdleTimer_timeout():
	#state = "PATROL"
	#_new_patrol_target()
