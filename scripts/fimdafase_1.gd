extends Area2D  # Tela de falha caso o jogador não tenha as estrelas suficientes

func _on_body_entered(body):
	if body.name == "milo1":  # Verifica se é o jogador
		# Verifica se o jogador tem as 3 estrelas
		if Globals.estrelas >= 3:
			get_tree().change_scene_to_file("res://level2.tscn")  # Muda para a próxima fase
		else:
			Globals.estrelas = 0
			Globals.vidas = 3
			get_tree().change_scene_to_file("res://telafalha.tscn")  # Muda para a tela de falha
