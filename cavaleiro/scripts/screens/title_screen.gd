extends Control

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/levels_screen.tscn")

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/controles_screen.tscn")

func _on_som_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/sound_screen.tscn")
