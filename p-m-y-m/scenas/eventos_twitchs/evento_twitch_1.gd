extends Node2D

var puntuacion = 0
var max_billetes = 5
@onready var timer_castigo = $TimerCastigo
@onready var mi_npc = $NPC

signal minijuego_ganado
func _ready():
	$NPC.parte_tocada.connect(_al_tocar_npc)
	timer_castigo.start()

func _al_tocar_npc(parte):
	match parte:
		"billetes":
			puntuacion += 1
			print("¡Billetes! Puntos: ", puntuacion)
			if puntuacion >= max_billetes:
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
	#mi_npc.call_deferred("queue_free")
	#await get_tree().create_timer(1.0).timeout
	emit_signal("minijuego_ganado")
	#get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
	NPCstates.npcs["npc1"]["current_state"] = "robado"
	get_tree().call_group("evento_1","JuegoTerminado")
	queue_free()
