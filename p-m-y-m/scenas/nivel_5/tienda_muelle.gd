extends Node2D


func _on_salida_muelle_pressed() -> void:
	get_tree().set_meta("posicion_inicial_luther", Vector2(900, 650))
	get_tree().change_scene_to_file("res://scenas/nivel_5/muelle.tscn")


func _on_salida_muelle_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_salida_muelle_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
