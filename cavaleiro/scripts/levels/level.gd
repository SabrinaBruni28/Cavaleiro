extends Node2D

@onready var final: Label = $Labels/Final
@onready var objetivo: Label = $Labels/Objetivo
@onready var moedas: Label = $Player/HUD/Moedas
@onready var pontos: Label = $Player/HUD/Pontos
@onready var level: Label = $Player/HUD/Level
var ganhou = false

func _ready() -> void:
	await get_tree().process_frame
	
	var total = get_tree().get_nodes_in_group("coin").size()
	GameManager.reset_level(total)
	objetivo.text = "Colete " + str(GameManager.max) + " moedas!"
	level.text = "Nível " + str(GameManager.level)

	$Player/Controles/GridContainer/Esquerda.visible = GameManager.mobile
	$Player/Controles/GridContainer/Direita.visible = GameManager.mobile
	$Player/Controles/Pular.visible = GameManager.mobile

func _process(_delta: float) -> void:
	_update_labels()
	if GameManager.moedas == GameManager.max and not ganhou: 
		GameManager.win()
		ganhou = true
		$Player.win = true

func _update_labels() -> void:
	final.text = "Você coletou " + str(GameManager.moedas) + " moedas!"
	moedas.text = str(GameManager.moedas)
	pontos.text = str(GameManager.score)

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")
