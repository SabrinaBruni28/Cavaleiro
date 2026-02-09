extends TextureButton

@export var pode_mover := true

var dragging := false
var touch_index := -1
var parent

func _ready() -> void:
	parent = get_parent()
	carregar_posicao()

func _gui_input(event):
	if not pode_mover:
		return

	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			touch_index = event.index
			accept_event()

		elif not event.pressed and event.index == touch_index:
			dragging = false
			touch_index = -1
			salvar_posicao()
			accept_event()

	elif event is InputEventScreenDrag:
		if dragging and event.index == touch_index:
			position += event.relative
			accept_event()

func salvar_posicao():
	var cfg := ConfigFile.new()
	cfg.load("user://mobile_ui.cfg")

	var tamanho = parent.size

	# posição normalizada (0..1 dentro do Control)
	var pos_normalizada := Vector2(
		position.x / tamanho.x,
		position.y / tamanho.y
	)

	cfg.set_value("buttons", name, pos_normalizada)
	cfg.save("user://mobile_ui.cfg")

func carregar_posicao():
	var cfg := ConfigFile.new()
	if cfg.load("user://mobile_ui.cfg") != OK:
		return
	if not cfg.has_section_key("buttons", name):
		return

	var pos_normalizada: Vector2 = cfg.get_value("buttons", name)
	var tamanho = parent.size

	position = Vector2(
		pos_normalizada.x * tamanho.x,
		pos_normalizada.y * tamanho.y
	)
