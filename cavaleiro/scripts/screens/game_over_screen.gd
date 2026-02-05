extends Control

func _on_again_button_pressed() -> void:
	GameManager.inicia_level()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
