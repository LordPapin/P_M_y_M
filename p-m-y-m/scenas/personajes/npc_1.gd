extends CharacterBody2D

var conversable = false

func _on_area_2d_input_event(_viewport, event: InputEvent, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		_handle_interaction()

func _handle_interaction():
	var state = NPCstates.npcs ["npc1"]["current_state"]
	match state:
		"no_interactuado":
			print("diálogo inicial")
			NPCstates.npcs["npc1"]["current_state"] = "no_sobornado"
		"no_sobornado":
			print("pide el soborno")
		"robado":
			print("es robado")
		"sobornado":
			print("información muy importante")



func _on_cercanía_de_conv_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		conversable = true


func _on_cercanía_de_conv_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		conversable = false
