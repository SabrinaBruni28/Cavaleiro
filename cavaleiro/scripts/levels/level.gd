extends Node2D

@onready var final: Label = $Labels/Final
@onready var objetivo: Label = $Labels/Objetivo
@onready var moedas: Label = $Player/Camera2D/GridContainer/Moedas
@onready var pontos: Label = $Player/Camera2D/GridContainer/Pontos
@onready var level: Label = $Player/Camera2D/GridContainer/Level
var ganhou = false

func _ready() -> void:
	await get_tree().process_frame
	
	var total = get_tree().get_nodes_in_group("coin").size()
	GameManager.reset_level(total)
	objetivo.text = "Colete " + str(GameManager.max) + " moedas!"
	level.text = "Nível " + str(GameManager.level)

func _process(_delta: float) -> void:
	_update_labels()
	if GameManager.moedas == GameManager.max and not ganhou: 
		GameManager.win()
		ganhou = true

func _update_labels() -> void:
	final.text = "Você coletou " + str(GameManager.moedas) + " moedas!"
	moedas.text = str(GameManager.moedas)
	pontos.text = str(GameManager.score)
	
