extends Control

@onready var vidas_label = $container/container_vidas/vidas_label as Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func atualizar_vidas():
	#if vidas_label:
	vidas_label.text = str("%01d" % Globals.vidas) 
	print("Texto atualizado para: ", vidas_label.text) 
	#else:
	#print("Erro: Vidas Label não encontrado!") 
