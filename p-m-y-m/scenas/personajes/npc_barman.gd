extends CharacterBody2D
var miniJuego = "res://scenas/eventos_twitchs/evento_twitch_1.tscn"
var conversable = false
@onready var MiSprite: AnimatedSprite2D = $AnimatedSprite2D


@onready var MiDialogo = preload ("res://dialogos/npc_barman.dialogue")
func _ready() -> void:
	MiSprite.play("idle")
	conversable = false
	pass


func _handle_interaction():
	var state = NPCstates.npcs ["npc_barman"]["current_state"]
	match state:
		"no_interactuado_sin_billetes":
			print("diálogo inicial")
			NPCstates.npcs["npc_barman"]["current_state"] = "interactuado_sin_billetes"
		"interactuado_sin_billetes":
			print("dialogo de boludeo")
		"con_billetes":
			print("nos dice pobres")

		

func _on_cercanía_de_conv_body_entered(body: Node2D) -> void:
	if body is personaje:
		conversable = true
		print(conversable)


func _on_cercanía_de_conv_body_exited(body: Node2D) -> void:
	if body is personaje:
		conversable = false
		print(conversable)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.pressed && conversable == true:
		DialogueManager.show_dialogue_balloon(MiDialogo, "start")
		await DialogueManager.dialogue_ended
		_handle_interaction()


#func _on_area_2d_2_body_entered(body: Node2D) -> void:
#	if body.is_in_group("jugador"):
#		DialogueManager.show_dialogue_balloon(MiDialogo, "start")
#		await DialogueManager.dialogue_ended
#		_handle_interaction()
		
#	pass # Replace with function body.


func _on_area_2d_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_area_2d_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
