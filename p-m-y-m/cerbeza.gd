extends Area2D

signal clicked(recurso)

const CERVEZA = preload("res://scenas/recursos/cerveza.tres")

@export var item_data: ItemData = CERVEZA


func _on_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit(self)
			var cursor = get_tree().get_first_node_in_group("cursor")
			cursor._set_estado(cursor.EstadoPuntero.CAMINAR)


func _on_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
