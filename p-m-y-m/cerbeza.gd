extends Area2D

signal clicked(recurso)

const CERVEZA = preload("res://scenas/recursos/cerveza.tres")

@export var item_data: ItemData = CERVEZA


func _on_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit(self)
