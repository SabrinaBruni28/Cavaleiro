extends Node

var score = 0
@onready var score_label: Label = $ScoreLabel
@onready var win_sound: AudioStreamPlayer2D = $WinSound

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func win_test() -> void:
	if get_tree().get_nodes_in_group("coin").size() <= 1:
		win_sound.play()
		await win_sound.finished
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
