extends Area2D

@export var milo1: CharacterBody2D  # Referência ao Milo1 (CharacterBody2D)

	
func _on_body_entered(body: Node) -> void:
	if body == milo1:  # Verifica se o corpo que entrou é o Milo1
		# Bloqueia o movimento de Milo1
		body.position = body.position  # Impede que ele ultrapasse a área
