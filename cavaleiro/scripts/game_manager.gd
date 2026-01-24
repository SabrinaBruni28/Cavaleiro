extends Node

var score = 0
var level = 1
var max_level = 1

func inicia_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_" + str(level) + ".tscn")

func add_point():
	score += 1
	GameManager.win_test()

func win_test() -> void:
	if get_tree().get_nodes_in_group("coin").size() <= 1:
		AudioManager.win_sound.play()
		await AudioManager.win_sound.finished
		if level < max_level: level += 1
		else: level = 1
		get_tree().change_scene_to_file("res://scenes/screens/win_screen.tscn")
