extends CharacterBody2D

@export var velocidade: float = 300.0  # Velocidade positiva para mover para a direita
@export var limite_x: float = 599  # Quando chegar aqui, reseta
@export var posicao_inicial: Vector2 = Vector2(62, 440)  # Onde o carro reaparece

func _physics_process(delta: float) -> void:
	velocity = Vector2(velocidade, 0)
	move_and_slide()

	if position.x > limite_x:  # Se passar do limite, reseta
		position = posicao_inicial
