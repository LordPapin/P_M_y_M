extends Node2D

@onready var MiniJuego = preload("res://scenas/eventos_twitchs/evento_twitch_1.tscn")

func minijuego():
	var evento = MiniJuego.instantiate()
	get_tree().paused = true
	add_child(evento)
	
	pass
func JuegoTerminado():
	get_tree().paused = false
	pass


func _on_puerta_entrada_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($"puerta entrada".global_position)
	print(distancia)
	if distancia < 645:
		get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")

func _on_puerta_salida_pressed() -> void:
	var distancia : int = $Luther.global_position.distance_to($"puerta salida".global_position)
	print(distancia)
	if distancia < 645:
		get_tree().change_scene_to_file("res://scenas/nivel_4/callejon.tscn")
