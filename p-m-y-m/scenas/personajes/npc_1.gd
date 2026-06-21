extends CharacterBody2D
var miniJuego = "res://scenas/eventos_twitchs/evento_twitch_1.tscn"
var conversable = false
var estado_local = "no_interactuado"


@onready var MiDialogo = preload ("res://dialogos/diálogo npc1.dialogue")

@export var billete_item: ItemData



func _ready() -> void:
	
	conversable = false
	pass


func _handle_interaction():
	# Usamos nuestra variable en lugar del diccionario problemático
	match estado_local:
		"no_interactuado":
			print("Entregando billete...")
			get_tree().call_group("evento_1", "minijuego")

			if billete_item != null:
				Inventory.add_item(billete_item)
			
			# Cambiamos nuestra variable local
			estado_local = "no_sobornado" 
			print("Estado cambiado a no_sobornado")
			
		"no_sobornado":
			print("Intentando consumir el billete...")
			var soborno_exitoso = Inventory.consume_item(billete_item.id)
			
			if soborno_exitoso:
				estado_local = "sobornado"
				print("¡Billete consumido! Pasando a sobornado")
			else:
				print("No se encontró el billete")
				

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


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		DialogueManager.show_dialogue_balloon(MiDialogo, "start")
		await DialogueManager.dialogue_ended
		_handle_interaction()
		
	pass # Replace with function body.
