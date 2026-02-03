extends AnimatableBody2D

@onready var area: Area2D = $Area2D
@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
var aberto: bool = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not aberto:
		AudioManager.pickup_sound.play()
		GameManager.add_moeda()
		sprites.play("bateu")
		animation.play("colete")
		aberto = true
