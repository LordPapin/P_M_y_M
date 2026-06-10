extends Area2D


const LLAVE = preload("uid://bjwkdgx8cwf6p")


@export var item_data: ItemData = LLAVE

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		var was_added = Inventory.add_item(item_data)
		
		if was_added:
			queue_free()
