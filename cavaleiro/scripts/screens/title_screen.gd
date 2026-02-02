extends Control

func _on_jogar_pressed() -> void:
	GameManager.inicia_level()

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/controles_screen.tscn")
