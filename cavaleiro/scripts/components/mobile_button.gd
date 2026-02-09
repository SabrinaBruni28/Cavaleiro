extends TouchScreenButton

func _ready():
	var cfg := ConfigFile.new()
	if cfg.load("user://mobile_ui.cfg") != OK:
		return
	if not cfg.has_section_key("buttons", name):
		return

	# posição salva (0..1)
	var pos_normalizada: Vector2 = cfg.get_value("buttons", name)

	# tamanho da tela
	var viewport_size := get_viewport_rect().size
	var pos_tela := pos_normalizada * viewport_size

	# centro da tela (Player está aqui)
	var centro_tela := viewport_size * 0.5

	# posição LOCAL ao Player
	var camera := get_viewport().get_camera_2d()
	position = (pos_tela - centro_tela) / camera.zoom
	print(position)
