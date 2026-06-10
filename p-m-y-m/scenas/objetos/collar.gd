extends Area2D


const COLLAR = preload("res://scenas/recursos/collar.tres")


@export var item_data: ItemData = COLLAR

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		var was_added = Inventory.add_item(item_data)
		
		if was_added:
			queue_free()
