extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	add_to_group("coin")

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	animation_player.play("pickup")

func _on_tree_exiting() -> void:
	game_manager.win_test()
