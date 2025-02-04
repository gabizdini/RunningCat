extends CharacterBody2D

@export var velocidade: float = -370.0  # Velocidade negativa para mover para a esquerda
@export var limite_x: float = -62  # Quando chegar aqui, reseta
@export var posicao_inicial: Vector2 = Vector2(599, 440)  # Onde o carro reaparece

func _physics_process(delta: float) -> void:
	velocity = Vector2(velocidade, 0)
	move_and_slide()

	if position.x < limite_x:
		position = posicao_inicial
