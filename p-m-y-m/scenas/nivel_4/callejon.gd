extends Node2D
@onready var minijuego2 = preload("res://scenas/eventos_twitchs/evento_twitch_2.tscn")
func instance():
	var minijuego = minijuego2.instantiate()
	get_tree().paused = true
	add_child(minijuego)
	pass

func quitar_pausa():
	get_tree().paused =false
	
