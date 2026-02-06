extends Area2D

@onready var timer: Timer = $Timer
var died = false

func _on_body_entered(body: Node2D) -> void:
	if died or not body.pode_interagir(): return
	Engine.time_scale = 0.5
	body.die()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/screens/game_over_screen.tscn")
