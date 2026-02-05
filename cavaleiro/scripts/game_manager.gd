extends Node

var score: int = 0
var moedas: int = 0
var max: int = 0
var level: int = 1
var max_level: int = 3
var level_disponível: int = 1
var mobile: bool

func _ready() -> void:
	mobile = OS.has_feature("mobile")
	SaveManager.load_game()

func inicia_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func add_moeda():
	moedas += 1

func add_point(pontos: int = 1):
	score += pontos

func reset_level(total):
	score = 0
	moedas = 0
	max = total

func win() -> void:
	AudioManager.win_sound.play()
	await AudioManager.win_sound.finished
	if level < max_level: 
		get_tree().change_scene_to_file("res://scenes/screens/win_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/screens/final_screen.tscn")
	if level == level_disponível:
		level_disponível += 1
	SaveManager.save_game()
