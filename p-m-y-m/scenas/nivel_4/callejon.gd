extends Node2D
@onready var minijuego2 = preload("res://scenas/eventos_twitchs/evento_twitch_2.tscn")


func _ready() -> void:
	$moscas.play("default")
	pass
func instance():
	var minijuego = minijuego2.instantiate()
	get_tree().paused = true
	add_child(minijuego)
	pass

func quitar_pausa():
	get_tree().paused =false
	


func _on_salida_calle_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($"salida calle".global_position)
	print(distancia)
	if distancia < 300:
		get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")


func _on_salida_bar_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($"salida bar".global_position)
	print(distancia)
	if distancia < 220:
		get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
		
