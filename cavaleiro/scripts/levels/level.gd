extends Node2D

@onready var score_label: Label = $Labels/ScoreLabel

func _ready() -> void:
	GameManager.score = 0
	
func _process(delta: float) -> void:
	score_label.text = "You collected " + str(GameManager.score) + " coins!"
