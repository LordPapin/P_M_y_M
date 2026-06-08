extends Node2D

@onready var MiniJuego = preload("res://scenas/eventos_twitchs/evento_twitch_1.tscn")
@onready var barista: AnimatedSprite2D = $Barista

func _ready() -> void:
	barista.play("idle")
func minijuego():
	var evento = MiniJuego.instantiate()
	get_tree().paused = true
	add_child(evento)
	
	pass
func JuegoTerminado():
	get_tree().paused = false
	pass
