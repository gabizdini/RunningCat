extends Area2D

var estrela := 1
@onready var milo = get_node("/root/level2/milo")  # Obtém o nó do jogador
@onready var milo1 = get_node("/root/level1/milo1")
func _on_body_entered(body: Node2D) -> void:
	if body != milo && body != milo1:  # 🔹 Só permite a coleta se "body" for "milo"
		return

	print("passou por aqui")  # ✅ Agora o print será exibido corretamente
	$colisao.set_deferred("disabled", true)  
	$anim.play("coletar")
	await $anim.animation_finished
	Globals.estrelas += estrela  # ✅ O contador será atualizado corretamente
	queue_free()
