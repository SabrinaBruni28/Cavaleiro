extends TouchScreenButton

const LIMITE_MIN = Vector2(-136, -104)
const LIMITE_MAX = Vector2(132, 48)

func _ready():
	var cfg := ConfigFile.new()
	if cfg.load("user://mobile_ui.cfg") != OK:
		return
	if not cfg.has_section_key("buttons", name):
		return

	var pos_normalizada: Vector2 = cfg.get_value("buttons", name)

	position = Vector2(
		lerp(LIMITE_MIN.x, LIMITE_MAX.x, pos_normalizada.x),
		lerp(LIMITE_MIN.y, LIMITE_MAX.y, pos_normalizada.y)
	)
