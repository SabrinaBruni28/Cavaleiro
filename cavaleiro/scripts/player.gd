extends CharacterBody2D

enum PlayerState { GROUND, AIR, WATER, DIE, WIN }
var state: PlayerState = PlayerState.AIR

var win = false
var died = false
var nadar = false
var no_gelo := false
var agua_count = 0
var gelo_count = 0

# Valores normais
const SPEED_NORMAL = 130.0
const JUMP_NORMAL = -300.0
const GRAVITY_NORMAL = 1.0
const ACCEL_NORMAL := 1200.0
const FRICTION_NORMAL := 1000.0

# Valores na água
const SPEED_AGUA = 30.0
const JUMP_AGUA = -180.0
const GRAVITY_AGUA = 0.3

# Valores no gelo
const ACCEL_GELO := 120.0
const FRICTION_GELO := 30.0
const SPEED_GELO := 160.0
const GELO_PUSH := 20.0

var speed = SPEED_NORMAL
var accel = ACCEL_NORMAL
var friction = FRICTION_NORMAL
var jump_velocity = JUMP_NORMAL
var gravity_scale = GRAVITY_NORMAL
var direction = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func estados():
	if win:
		state = PlayerState.WIN
	elif died:
		state = PlayerState.DIE
	elif nadar:
		state = PlayerState.WATER
	elif is_on_floor():
		state = PlayerState.GROUND
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

		PlayerState.WIN:
			velocity.y += get_gravity().y * gravity_scale * delta
			velocity.x = 0

func movimento(delta):
	if not pode_interagir():
		return

	direction = Input.get_axis("esquerda", "direita")

	if direction != 0:
		velocity.x = move_toward(
			velocity.x,
			direction * speed,
			accel * delta
		)
	else:
		if no_gelo:
			velocity.x *= 0.99
		else:
			# chão normal
			velocity.x = move_toward(
				velocity.x,
				0,
				friction * delta
			)

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
		
		PlayerState.WIN:
			play_anim("win")

func _physics_process(delta: float) -> void:
	estados()
	pulo()
	gravidade(delta)
	movimento(delta)
	animacao()
	move_and_slide()

func die():
	died = true
	AudioManager.dying_sound.play()

func play_anim(name: String) -> void:
	if animated_sprite.animation != name:
		animated_sprite.play(name)

func pode_interagir() -> bool:
	return state != PlayerState.DIE and state != PlayerState.WIN

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("agua"):
		agua_count += 1
		nadar = true
		velocity.y *= 0.5
		speed = SPEED_AGUA
		jump_velocity = JUMP_AGUA
		gravity_scale = GRAVITY_AGUA
	elif area.is_in_group("gelo"):
		gelo_count += 1
		no_gelo = true
		accel = ACCEL_GELO
		friction = FRICTION_GELO
		speed = SPEED_GELO
		if abs(velocity.x) == 0:
			var dir = direction
			if dir == 0:
				dir = -1 if animated_sprite.flip_h else 1
			velocity.x = GELO_PUSH * dir

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("agua"):
		agua_count -= 1
		if agua_count <= 0:
			nadar = false
			speed = SPEED_NORMAL
			jump_velocity = JUMP_NORMAL
			gravity_scale = GRAVITY_NORMAL
	elif area.is_in_group("gelo"):
		gelo_count -= 1
		if gelo_count <= 0:
			no_gelo = false
			accel = ACCEL_NORMAL
			friction = FRICTION_NORMAL
			speed = SPEED_NORMAL
		
