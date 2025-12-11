extends Node2D

var final_scene = load("res://game_scenes/final_view_port.tscn")
@onready var player = $MainCharacter

func _on_area_2d_area_entered(area):
	# teleport to last section
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_packed(final_scene)
