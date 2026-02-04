extends Node

var score = 0
var moedas = 0
var max = 0
var level = 1
var max_level = 2

func inicia_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func add_moeda():
	moedas += 1
	print("moeda:", moedas)

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
		level += 1
		get_tree().change_scene_to_file("res://scenes/screens/win_screen.tscn")
	else: 
		level = 1
		get_tree().change_scene_to_file("res://scenes/screens/final_screen.tscn")
