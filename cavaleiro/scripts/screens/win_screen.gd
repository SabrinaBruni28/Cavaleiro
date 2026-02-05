extends Control
@onready var pontos: Label = $MarginContainer/HBoxContainer/VBoxContainer/Pontos

func _ready() -> void:
	pontos.text = "Pontos: " + str(GameManager.score)

func _on_next_button_pressed() -> void:
	GameManager.inicia_level()
