extends Control

@onready var contador_estrelas = $container2/container_estrelas/contador_estrelas as Label

func _ready() -> void:
	contador_estrelas.text = str("%01d" % Globals.estrelas)

func _process(delta: float) -> void:
	contador_estrelas.text = str("%01d" % Globals.estrelas)
