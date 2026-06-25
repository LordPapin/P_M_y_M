extends Node2D


func _on_salida_muelle_pressed() -> void:
	get_tree().change_scene_to_file("res://scenas/nivel_5/muelle.tscn")
