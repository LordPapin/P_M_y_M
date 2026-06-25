extends Node2D


func _on_calle_btn_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($calle_btn.global_position)
	print(distancia)
	if distancia <500:
		get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
