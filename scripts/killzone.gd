extends Area2D

@onready var timer: Timer = $Timer
@onready var dying_sound: AudioStreamPlayer2D = $DyingSound

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.die()
	dying_sound.play()
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
