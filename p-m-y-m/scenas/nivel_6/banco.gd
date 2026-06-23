extends Node2D


func _on_texture_button_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($TextureButton.global_position)
	print(distancia)
	if distancia < 280:
		get_tree().change_scene_to_file("res://scenas/nivel_6/interior_banco.tscn")
