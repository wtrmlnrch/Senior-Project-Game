extends Node2D

@export var is_tutorial: bool = false

func _on_hide_region_body_entered(body):
	body.can_hide = true
	if is_tutorial:
		$RichTextLabel.visible = true

func _on_hide_region_body_exited(body):
	body.can_hide = false
	body.is_hidden = false
	body.get_child(2).visible = true
	if is_tutorial:
		$RichTextLabel.visible = false
