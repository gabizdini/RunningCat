extends Node2D

@onready var camera = $camera as Camera2D
@onready var milo = $milo1 as CharacterBody2D
@onready var inimigos = []
const spawn_top_position = Vector2(335, 299)  # Posição inicial
@onready var hud = $HUD/Control as Control
@onready var music_player = $musica as AudioStreamPlayer

# Define os limites da câmera na largura
const SCREEN_WIDTH = 640
const SCREEN_HEIGHT = 320

func _ready() -> void:
	music_player.play()
	music_player.finished.connect(_on_music_finished)
	# Configura a câmera para seguir o personagem
	milo.seguir_camera(camera)
	# Define apenas os limites laterais da câmera
	camera.limit_left = 0
	camera.limit_right = SCREEN_WIDTH
	
	# Atualiza a posição inicial do personagem
	milo.position = spawn_top_position
	
	# Atualiza as vidas no HUD
	hud.atualizar_vidas()

func _on_music_finished():
	music_player.play() 
	
func _process(delta: float) -> void:
	# Faz a câmera seguir o personagem sem ultrapassar os limites laterais
	camera.position.x = clamp(milo.position.x, SCREEN_WIDTH / 2, SCREEN_WIDTH / 2)
	camera.position.y = milo.position.y  # Livre para se mover na vertical

func reiniciar_fase():
	$reiniciar_jogo.start()

func _on_reiniciar_jogo_timeout() -> void:
	get_tree().reload_current_scene()
