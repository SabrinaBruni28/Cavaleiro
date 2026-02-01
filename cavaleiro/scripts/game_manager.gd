extends Node

var score = 0
var max_score = 0
var level = 1
var max_level = 1

func inicia_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func add_point():
	score += 1
	if score == max_score: win()

func reset_level(total):
	score = 0
	max_score = total

func win() -> void:
	AudioManager.win_sound.play()
	get_tree().paused = true
	await AudioManager.win_sound.finished
	if level < max_level: 
		level += 1
		get_tree().change_scene_to_file("res://scenes/screens/win_screen.tscn")
	else: 
		level = 1
		get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
	get_tree().paused = false
