extends Node2D


func _on_texture_button_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($puerta.global_position)
	print(distancia)
	if distancia < 280:
		get_tree().change_scene_to_file("res://scenas/nivel_6/interior_banco.tscn")


func _on_calle_tbn_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($calle_tbn.global_position)
	print(distancia)
	if distancia < 400:
		get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
