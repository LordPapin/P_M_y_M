extends CharacterBody2D
var conversable = false
@onready var MiSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var distancia_conversacion := 250.0

@onready var MiDialogo = preload ("res://dialogos/npc_cajera.dialogue")
func _ready() -> void:
	MiSprite.play("idle")
	conversable = false
	pass


func _handle_interaction():
	var state = NPCstates.npcs ["npc_cajera"]["current_state"]
	match state:
		"no_interactuado":
			NPCstates.npcs["npc_cajera"]["current_state"] = "interactuado"
		"interactuado":
			pass

		

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
			var luther = get_tree().get_first_node_in_group("jugador")
			
			if luther == null:
				return
			
			if luther.conversando:
				return
			
			if conversable:
				luther.iniciar_conversacion(self)
			else:
				luther.ir_hacia_npc(self)


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


func iniciar_dialogo() -> void:
	DialogueManager.show_dialogue_balloon(MiDialogo, "start")
	await DialogueManager.dialogue_ended
	
	_handle_interaction()
	
	var luther = get_tree().get_first_node_in_group("jugador")
	if luther:
		luther.terminar_conversacion()
