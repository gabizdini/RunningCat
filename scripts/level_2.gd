extends Node2D
@onready var camera = $camera as Camera2D
@onready var milo = $milo as CharacterBody2D
@onready var inimigos = []
const spawn_top_position = Vector2(-244, 86)
@onready var hud = $HUD/Control as Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	milo.seguir_camera(camera)
	inimigos = get_tree().get_nodes_in_group("inimigos")
	milo.position = spawn_top_position
	hud.atualizar_vidas()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reiniciar_fase():
	$reiniciar_jogo.start()

func _on_reiniciar_jogo_timeout() -> void:
	get_tree().reload_current_scene()
