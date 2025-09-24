extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
