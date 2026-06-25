extends Node2D

func _on_calle_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($calle.global_position)
	print(distancia)
	if distancia < 220:
		get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")


func _on_tienda_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($tienda.global_position)
	print(distancia)
	if distancia <900:
		get_tree().change_scene_to_file("res://scenas/nivel_5/tienda_muelle.tscn")
