extends CharacterBody2D

signal comenzar_minijuego

var miniJuego = "res://scenas/eventos_twitchs/Evento_twitch_3.tscn"
var conversable = false
@onready var MiSprite: AnimatedSprite2D 
@export var distancia_conversacion := 100.0
@onready var luther = get_tree().get_first_node_in_group("jugador")

@onready var MiDialogo = preload("res://dialogos/npc_pescador.dialogue")

func _ready() -> void:
	conversable = false

func _handle_interaction():
	var state = NPCstates.npcs["npc_pescador"]["current_state"]
	
	# Si el diálogo terminó en este estado, significa que el jugador aceptó ayudarlo
	if state == "borracho_con_info_sin_ayuda_conversado":
		print("Cambiando a la escena del minijuego de pesca...")
		
		# Cambiamos el estado para que, al volver del minijuego, salte directo a la recompensa
		#NPCstates.npcs["npc_pescador"]["current_state"] = "borracho_con_info_con_ayuda"
		
		# Cambiar de escena al minijuego
		emit_signal("comenzar_minijuego")

func _on_cercanía_de_conv_body_entered(body: Node2D) -> void:
	if body is personaje:
		conversable = true
		if body.npc_objetivo == self:
			body.iniciar_conversacion(self)

func _on_cercanía_de_conv_body_exited(body: Node2D) -> void:
	if body is personaje:
		conversable = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if luther == null or luther.conversando:
				return
			
			if conversable:
				luther.iniciar_conversacion(self)
			else:
				luther.ir_hacia_npc(self)

func _on_area_2d_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)

func _on_area_2d_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()

func iniciar_dialogo() -> void:
	DialogueManager.show_dialogue_balloon(MiDialogo, "start")
	await DialogueManager.dialogue_ended
	
	# Se ejecuta inmediatamente al cerrar la caja de texto
	_handle_interaction()
	
	if luther:
		luther.terminar_conversacion()
