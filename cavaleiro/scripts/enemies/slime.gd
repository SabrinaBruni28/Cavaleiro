extends CharacterBody2D

const SPEED = 60
const GRAVITY = 900
var direction = -1
var died = false
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var killzone: Area2D = $Killzone

func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Mudança de direção ao bater na parede
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	# Movimento horizontal
	velocity.x = direction * SPEED

	move_and_slide()

func die():
	died = true
	killzone.monitoring = false
	killzone.died = true

	# desativa colisões IMEDIATAMENTE
	set_collision_layer(0)
	set_collision_mask(0)

	animated_sprite.play("die")
	GameManager.add_point(10)
	AudioManager.morte_inimigo_sound.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if died: return
	body.pular()
	die()
