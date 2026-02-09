extends TextureButton

@export var pode_mover := true

var dragging := false
var offset := Vector2.ZERO
var touch_index := -1

func _ready() -> void:
	carregar_posicao()

func _gui_input(event):
	if not pode_mover:
		return

	# TOQUE
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			touch_index = event.index
			offset = get_local_mouse_position()
			accept_event()

		elif not event.pressed and event.index == touch_index:
			dragging = false
			touch_index = -1
			salvar_posicao()
			accept_event()

	# ARRASTE
	elif event is InputEventScreenDrag:
		if dragging and event.index == touch_index:
			position += event.relative
			accept_event()

func salvar_posicao():
	var cfg := ConfigFile.new()
	cfg.load("user://mobile_ui.cfg")

	var viewport_size = get_viewport_rect().size
	var pos_normalizada = global_position / viewport_size

	cfg.set_value("buttons", name, pos_normalizada)
	cfg.save("user://mobile_ui.cfg")

func carregar_posicao():
	var cfg := ConfigFile.new()
	if cfg.load("user://mobile_ui.cfg") != OK:
		return

	if not cfg.has_section_key("buttons", name):
		return

	var viewport_size = get_viewport_rect().size
	var pos_normalizada = cfg.get_value("buttons", name)

	global_position = pos_normalizada * viewport_size
	print(global_position)
