extends Area2D

signal clicked(recurso)

const COLLAR = preload("res://scenas/recursos/collar.tres")

@export var item_data: ItemData = COLLAR


func _on_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit(self)
