extends Control

@onready var container: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer
@onready var level_button: Button = container.get_node("Level")
@onready var cavaleiro: AnimatedSprite2D = $Cavaleiro

var target_level: int = 0
var moving := false

func _ready():
	level_button.hide()

	var total_levels = GameManager.max_level
	var screen_width = get_viewport_rect().size.x

	# Espaçamento proporcional à tela
	var separation = clamp(
		(screen_width * 0.8) / total_levels,
		5,
		300
	)
	container.add_theme_constant_override("separation", separation)

	for i in range(1, total_levels + 1):
		create_level_button(i)

func create_level_button(level_number: int):
	var btn: Button = level_button.duplicate()
	btn.show()
	btn.text = str(level_number)

	if level_number > GameManager.level_disponível:
		btn.disabled = true
	else:
		btn.pressed.connect(func():
			if not moving:
				move_cavaleiro_to_button(btn, level_number)
		)

	container.add_child(btn)

func move_cavaleiro_to_button(btn: Button, level_number: int):
	moving = true
	target_level = level_number

	var target_x = btn.global_position.x + btn.size.x / 2
	var cavaleiro_pos = cavaleiro.global_position

	# Direção
	cavaleiro.flip_h = target_x < cavaleiro_pos.x
	cavaleiro.play("andar")

	var tween = create_tween()
	tween.tween_property(
		cavaleiro,
		"global_position",
		Vector2(target_x, cavaleiro_pos.y),
		0.6
	).set_trans(Tween.TRANS_LINEAR)

	tween.finished.connect(_on_cavaleiro_chegou)

func _on_cavaleiro_chegou():
	cavaleiro.play("idle")
	moving = false
	await get_tree().create_timer(0.4).timeout

	GameManager.level = target_level
	GameManager.inicia_level()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
