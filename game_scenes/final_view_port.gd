extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()
	$Deer/AnimationPlayer.play("new_animation")
