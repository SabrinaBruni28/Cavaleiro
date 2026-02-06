extends Control

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/levels_screen.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
