extends Node2D

@export var deadzone_y := 40.0
@export var follow_speed := 10.0

@export var min_screen_y := 20.0   # nunca passa do topo
@export var max_screen_y := 120.0  # quanto pode descer

@onready var player := get_tree().get_first_node_in_group("player")

var y_base: float
var screen_offset: Vector2

func _ready():
	if not player:
		push_error("Player não encontrado")
		return

	var size = get_viewport_rect().size

	screen_offset = Vector2(-150, -size.y / 2 + min_screen_y)

	y_base = player.global_position.y + screen_offset.y
	global_position = player.global_position + screen_offset

func _process(delta):
	if not player:
		return

	# X sempre acompanha
	global_position.x = player.global_position.x + screen_offset.x

	var target_y = player.global_position.y + screen_offset.y

	# deadzone
	if abs(target_y - y_base) > deadzone_y:
		y_base = lerp(y_base, target_y, follow_speed * delta)

	# 🔒 trava dentro da tela
	var top_limit = player.global_position.y - get_viewport_rect().size.y / 2 + min_screen_y
	var bottom_limit = player.global_position.y - get_viewport_rect().size.y / 2 + max_screen_y

	y_base = clamp(y_base, top_limit, bottom_limit)

	global_position.y = y_base
