extends Node2D

@onready var MiniJuego = preload("res://scenas/eventos_twitchs/evento_twitch_1.tscn")


#conseguimos referencia a Luther
@onready var luther: personaje = $Luther

#conseguimos referencia a puertas
@onready var puerta_entrada_btn: TextureButton = $"puerta entrada"
@onready var puerta_salida_btn: TextureButton = $"puerta salida"


#conseguimos referencia a la posicion de las puertas(un nodo 2D personalizado)

@onready var posicion_entrada= $posicion_entrada.global_position
@onready var posicion_salida = $posicion_salida.global_position


#usamos booleanos para controlar hacia donde quiere viajar el jugador
#serán manejadas por las señales de botones presionados
var quiere_entrada = false
var quiere_salida = false

func minijuego():
	var evento = MiniJuego.instantiate()
	get_tree().paused = true
	add_child(evento)
	
	pass
func JuegoTerminado():
	get_tree().paused = false
	pass

func _process(delta: float) -> void:
	verificar_distancia()

func _on_puerta_entrada_pressed() -> void:
	luther.quiere_viajar = true
	quiere_entrada = true

func _on_puerta_salida_pressed() -> void:
	luther.quiere_viajar = true
	quiere_salida = true


func verificar_distancia():
	if not luther.quiere_viajar:
		quiere_entrada = false
		quiere_salida = false
		return
		
	if quiere_entrada:
		var distancia_entrada : float = luther.global_position.distance_to(posicion_entrada)
		if distancia_entrada > 100:
			luther.ir_hacia_puerta(posicion_entrada)
		else: # Esto equivale a <= 100
			get_tree().set_meta("posicion_inicial_luther", Vector2(3200, 530))
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
			
	if quiere_salida:
		var distancia_salida : float = luther.global_position.distance_to(posicion_salida)
		if distancia_salida > 100:
			luther.ir_hacia_puerta(posicion_salida)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_4/callejon.tscn")
			luther.quiere_viajar = false
	
