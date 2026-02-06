extends Control

@onready var check_button: CheckButton = $CheckButton

func _ready() -> void:
	check_button.button_pressed = GameManager.mobile

func _on_check_button_toggled(button_pressed: bool) -> void:
	GameManager.mobile = button_pressed

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
