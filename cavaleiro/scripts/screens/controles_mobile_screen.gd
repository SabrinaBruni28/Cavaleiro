extends Control

@onready var pular: TextureButton = $Controles/Pular
@onready var esquerda: TextureButton = $Controles/Esquerda
@onready var direita: TextureButton = $Controles/Direita

func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/controles_screen.tscn")

func _on_reset_pressed() -> void:
	pular.position = pular.posicao_padrao
	pular.salvar_posicao()
	esquerda.position = esquerda.posicao_padrao
	esquerda.salvar_posicao()
	direita.position = direita.posicao_padrao
	direita.salvar_posicao()
