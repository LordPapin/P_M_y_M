extends Node2D

var puntuacion = 0
var max_puntuacion = 5
@onready var timer_castigo = $TimerCastigo # Crea un Timer de 0.75s

func _ready():
	$NPC.parte_tocada.connect(_al_tocar_npc)
	timer_castigo.start()

func _al_tocar_npc(parte):
	match parte:
		"billetes":
			puntuacion += 1
			print("¡Billetes! Puntos: ", puntuacion)
			if puntuacion >= max_puntuacion:
				ganar_juego()
		"culo":
			derrota("SLAP")
		"cabeza":
			derrota("OJO")

func _on_timer_castigo_timeout():
	if puntuacion > 0:
		puntuacion -= 1
		print("Penalización por tiempo. Puntos: ", puntuacion)

func derrota(tipo):
	timer_castigo.stop()
	if tipo == "SLAP":
		print("Animación de bofetada y enojo")
	else:
		print("Lengua en el ojo")

func ganar_juego():
	print("ganaste")
