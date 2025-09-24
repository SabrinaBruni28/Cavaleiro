extends Node2D

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	game_manager.level = 1
