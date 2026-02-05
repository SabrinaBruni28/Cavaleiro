extends CharacterBody2D

enum PlayerState { GROUND, AIR, WATER, DIE }
var state: PlayerState = PlayerState.AIR

var died = false
var nadar = false
var agua_count = 0

# Valores normais
const SPEED_NORMAL = 130.0
const JUMP_NORMAL = -300.0
const GRAVITY_NORMAL = 1.0

# Valores na água
const SPEED_AGUA = 30.0
const JUMP_AGUA = -180.0
const GRAVITY_AGUA = 0.3

var speed = SPEED_NORMAL
var jump_velocity = JUMP_NORMAL
var gravity_scale = GRAVITY_NORMAL
var direction

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var is_mobile = OS.has_feature("mobile")

	$Esquerda.visible = is_mobile
	$Direita.visible = is_mobile
	$Pular.visible = is_mobile

func estados():
	if died:
		state = PlayerState.DIE
	elif is_on_floor():
		state = PlayerState.GROUND
	elif nadar:
		state = PlayerState.WATER
	else:
		state = PlayerState.AIR

func pulo():
	if Input.is_action_just_pressed("pular"):
		if state == PlayerState.WATER or state == PlayerState.GROUND:
			pular()

func pular():
	velocity.y = jump_velocity
	AudioManager.jump_sound.play()

func gravidade(delta):
	match state:
		PlayerState.WATER:
			velocity.y += get_gravity().y * gravity_scale * delta
			velocity.y = clamp(velocity.y, -400.0, 80.0)

		PlayerState.AIR:
			velocity += get_gravity() * gravity_scale * delta

		PlayerState.DIE:
			velocity = Vector2.ZERO

func movimento():
	direction = Input.get_axis("esquerda", "direita")

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func animacao():
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	match state:
		PlayerState.DIE:
			play_anim("die")

		PlayerState.WATER:
			play_anim("nadar")

		PlayerState.GROUND:
			if direction == 0:
				play_anim("idle")
			else:
				play_anim("run")

		PlayerState.AIR:
			play_anim("jump")

func _physics_process(delta: float) -> void:
	estados()
	pulo()
	gravidade(delta)
	movimento()
	animacao()
	move_and_slide()

func die():
	died = true
	collision.queue_free()
	AudioManager.dying_sound.play()

func play_anim(name: String) -> void:
	if animated_sprite.animation != name:
		animated_sprite.play(name)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("agua"):
		agua_count += 1
		nadar = true
		velocity.y *= 0.5
		speed = SPEED_AGUA
		jump_velocity = JUMP_AGUA
		gravity_scale = GRAVITY_AGUA

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("agua"):
		agua_count -= 1
		if agua_count <= 0:
			nadar = false
			speed = SPEED_NORMAL
			jump_velocity = JUMP_NORMAL
			gravity_scale = GRAVITY_NORMAL

func _on_esquerda_button_down():
	Input.action_press("esquerda")

func _on_esquerda_button_up():
	Input.action_release("esquerda")

func _on_direita_button_down():
	Input.action_press("direita")

func _on_direita_button_up():
	Input.action_release("direita")

func _on_pular_button_down():
	Input.action_press("pular")

func _on_pular_button_up():
	Input.action_release("pular")
