extends Area2D

func _on_body_entered(body):
	print(body.name)  # Verifica qual corpo entrou na área
	if body.name == "milo":  # Verifica se é o jogador
		if Globals.estrelas >= 10:
			print("Estrelas suficientes! Indo para a tela de vitória.")
			Globals.estrelas = 0
			Globals.vidas = 3
			get_tree().change_scene_to_file("res://telavitoria.tscn")  # Muda para a próxima fase
		else:
			Globals.estrelas = 0
			Globals.vidas = 3
			print("Estrelas insuficientes! Indo para a tela de falha.")
			get_tree().change_scene_to_file("res://telafalha_2.tscn")  # Muda para a tela de falha
