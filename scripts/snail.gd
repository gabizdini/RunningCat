extends CharacterBody2D

const SPEED = 800.0
var direction = 1

@onready var anim = $AnimatedSprite2D
@onready var raycast = $bate_volta  # Certifique-se de que o nome do nó é correto

func _ready() -> void:
	# Inicializa a direção do sprite
	anim.flip_h = true

func _physics_process(delta: float) -> void:
	# Aplica a gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Verifica se o raycast está colidindo
	if raycast.is_colliding():
		direction *= -1  # Inverte a direção ao colidir
		raycast.scale.x = direction
		anim.scale.x = abs(anim.scale.x) * direction   # Atualiza a orientação do sprite

	# Movimenta o personagem
	velocity.x = direction * SPEED * delta
	move_and_slide()
