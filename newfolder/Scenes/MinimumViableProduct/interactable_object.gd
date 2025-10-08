extends StaticBody2D
class_name InteractableObject

var is_near: bool = false
signal isNear
signal isGone

func _process(_delta):
		if is_near and Input.is_action_just_pressed("Interact"):
			interact()

func interact():
	print('object')

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_near = true
	isNear.emit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_near = false
	isGone.emit()
