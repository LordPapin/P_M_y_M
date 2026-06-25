extends Node2D



func _on_salir_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_jugar_button_down() -> void:
	get_tree().change_scene_to_file("res://scenas/intro/intro.tscn")
	pass # Replace with function body.
