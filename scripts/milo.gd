extends CharacterBody2D


const speed = 150.0  
const jump_velocity = -400.0 
@onready var jump_sound = $JumpSound

const fall_limit = 389 

@onready var anim = $AnimatedSprite2D
@onready var remote = $remote as RemoteTransform2D
@onready var hud = get_node("/root/level2/HUD/Control")
# Variável de controle para piscar
var is_blinking = false

func _ready() -> void:
	anim.play("idle")
	anim.flip_h = true  
	velocity = Vector2.ZERO
	#hud.atualizar_vidas(vidas)

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Se o personagem estiver no chão
	if is_on_floor():
		# Movimento horizontal
		if direction != 0:
			velocity.x = direction * speed
			# Inverte a animação quando estiver indo para a esquerda
			if direction > 0:
				anim.flip_h = true  # Inverte horizontalmente
			elif direction < 0:
				anim.flip_h = false  # Restaura a orientação original

			# Se a animação de corrida não estiver tocando, toca a animação de corrida
			if not anim.is_playing() or anim.animation != "run":
				anim.play("run")
		else:
			velocity.x = 0
			# Se a animação de idle não estiver tocando, toca a animação de parada
			if not anim.is_playing() or anim.animation != "idle":
				anim.play("idle")
	
		# Comando para o pulo, acionado com "ui_up"
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = jump_velocity  # Faz o pulo e toca a animação de pulo
			if not anim.is_playing() or anim.animation != "jump":
				anim.play("jump")
	else:
		# No ar, o personagem pode se mover horizontalmente, mas mantém a animação de pulo
		if direction != 0:
			velocity.x = direction * speed
			# Inverte a animação no ar, da mesma forma que no chão
			if direction > 0:
				anim.flip_h = true
			elif direction < 0:
				anim.flip_h = false
		# Se não estiver no chão, o personagem fica com a animação de pulo
		if not anim.is_playing() or anim.animation != "jump":
			anim.play("jump") 
	
	# Aplica a gravidade
	velocity += get_gravity() * delta

	move_and_slide()

	# Teleporta o personagem de volta ao topo se ele cair abaixo do limite
	if position.y > fall_limit:
		Globals.vidas = 3
		hud.atualizar_vidas()
		Globals.estrelas = 0
		get_tree().current_scene.reiniciar_fase()


func _on_dano_milo_body_entered(body: Node2D) -> void:
	if body.is_in_group("inimigos") and not is_blinking:
		Globals.vidas -= 1
		hud.atualizar_vidas()
		_start_blinking()

		if Globals.vidas <= 0:
			Globals.vidas = 3
			Globals.estrelas = 0
			get_tree().current_scene.reiniciar_fase()
			
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


func seguir_camera(camera):
	var caminho_camera = camera.get_path()
	remote.remote_path = caminho_camera
