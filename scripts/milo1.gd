extends CharacterBody2D

const speed = 150.0  

@onready var anim = $AnimatedSprite2D
@onready var hud = get_node("/root/level1/HUD/Control")

# Variável de controle para piscar
var is_blinking = false

func _ready() -> void:
	anim.play("idle")
	anim.flip_h = true  
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	# Movimento horizontal (x)
	if direction_x != 0:
		velocity.x = direction_x * speed
		# Inverte a animação quando estiver indo para a esquerda
		if direction_x > 0:
			anim.flip_h = true  # Inverte horizontalmente
		elif direction_x < 0:
			anim.flip_h = false  # Restaura a orientação original

		# Se a animação de corrida não estiver tocando, toca a animação de corrida
		if not anim.is_playing() or anim.animation != "run":
			anim.play("run")
	else:
		velocity.x = 0
	
	# Movimento vertical (y)
	if direction_y != 0:
		velocity.y = direction_y * speed
		# Se a animação de corrida não estiver tocando, toca a animação de corrida
		if not anim.is_playing() or anim.animation != "run":
			anim.play("run")
	else:
		velocity.y = 0
	
	# Se o personagem não estiver se movendo em nenhuma direção, coloca a animação de idle
	if velocity.x == 0 and velocity.y == 0:
		if not anim.is_playing() or anim.animation != "idle":
			anim.play("idle")
	
	# Move o personagem
	move_and_slide()

func _start_blinking() -> void:
	is_blinking = true
	_blink(6)  

func _blink(times_left: int) -> void:
	if times_left > 0:
		anim.visible = not anim.visible  
		await wait(0.1)  
		_blink(times_left - 1)
	else:
		anim.visible = true  
		is_blinking = false

func wait(duration: float) -> void:
	await get_tree().create_timer(duration).timeout
	
func seguir_camera(camera: Camera2D) -> void:
	camera.position = self.position


func _on_dano_milo_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos") and not is_blinking:
		print("passou")
		Globals.vidas -= 1
		hud.atualizar_vidas()
		_start_blinking()
		position = Vector2(335, 299)

		if Globals.vidas <= 0:
			Globals.vidas = 3
			#Globals.estrelas = 0 #a animação da estrela não reseta
			hud.atualizar_vidas()
			get_tree().current_scene.reiniciar_fase()
