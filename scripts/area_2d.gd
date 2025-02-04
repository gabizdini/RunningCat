extends Area2D

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Botão clicado!")  # Aqui você pode trocar de cena, tocar som etc.
		get_tree().change_scene_to_file("res://level1.tscn")  # Muda para a cena do jogo
