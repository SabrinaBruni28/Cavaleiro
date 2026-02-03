extends Node2D

@onready var final: Label = $Labels/Final
@onready var objetivo: Label = $Labels/Objetivo

func _ready() -> void:
	await get_tree().process_frame
	
	var total = get_tree().get_nodes_in_group("coin").size()
	GameManager.reset_level(total)
	objetivo.text = "Colete " + str(GameManager.max) + " moedas!"

func _process(_delta: float) -> void:
	_update_labels()
	if GameManager.moedas == GameManager.max: GameManager.win()

func _update_labels() -> void:
	final.text = "Você coletou " + str(GameManager.score) + " moedas!"
	
