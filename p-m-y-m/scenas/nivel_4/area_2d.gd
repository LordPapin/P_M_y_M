extends Area2D

@onready var minijuego2 = preload("res://scenas/eventos_twitchs/evento_twitch_2.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		get_tree().call_group("nivel_3", "instance")
	pass # Replace with function body.

func quitar_pausa():
	queue_free()
