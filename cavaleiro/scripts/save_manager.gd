extends Node
# Caminho do arquivo de save
const SAVE_PATH := "user://nivel.save"

func save_game() -> void:
	var data := {
		"nivel_atual": GameManager.level_disponível,
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))  # salva com indentação
		file.close()
		print("💾 Progresso salvo")
	else:
		push_error("❌ Erro ao salvar o progresso! Não foi possível abrir o arquivo.")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠️ Nenhum save encontrado.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("❌ Erro ao abrir o arquivo de save!")
		return

	var text = file.get_as_text()
	file.close()

	var json = JSON.parse_string(text)
	if typeof(json) != TYPE_DICTIONARY:
		push_error("❌ Erro ao carregar save: arquivo corrompido ou formato inválido.")
		return

	var data: Dictionary = json

	# Restaura os dados
	GameManager.level_disponível = data.get("nivel_atual", 1)

	print("✅ Save carregado com sucesso!")
	print("Level: ", GameManager.level_disponível)

func delete_save() -> void:
	reset_progresso()
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠️ Nenhum arquivo de save encontrado para deletar.")
		return
	DirAccess.remove_absolute(SAVE_PATH)
	print("🗑️ Arquivo de save deletado com sucesso!")

# 🔁 Reseta o progresso na memória (não apaga o arquivo)
func reset_progresso() -> void:
	GameManager.level = 1
	print("🔄 Progresso reiniciado (memória limpa, mas arquivo mantido).")
