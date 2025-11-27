extends Control


func _on_quit_pressed():
	get_tree().quit()


	


func _on_start_pressed():
	get_tree().change_scene_to_file("res://game_scenes/interiors/clinic.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://MainMenu/Settings.tscn")
