extends Node2D



func _on_puerta_bar_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($"puerta_bar".global_position)
	print(distancia)
	if distancia < 600:
		get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")


func _on_callejon_btn_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($callejon_btn.global_position)
	print(distancia)
	if distancia < 400:
		get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
