extends Node2D
@onready var music_player = $musica as AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	music_player.play()
	music_player.finished.connect(_on_music_finished)

func _on_music_finished():
	music_player.play() 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
