extends CharacterBody2D


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
