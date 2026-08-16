extends Node2D
@onready var minijuego2 = preload("res://scenas/eventos_twitchs/evento_twitch_2.tscn")

#conseguimos referencia a Luther
@onready var luther: personaje = $Luther

#conseguimos referencia a puertas
@onready var salida_calle: TextureButton = $"salida calle"

#conseguimos referencia a la posicion de las puertas(un nodo 2D personalizado)
@onready var posicion_salida_cjn = $posicion_salida_cjn.global_position

@onready var posicion_salida_bar: = $posicion_salida_bar

var quiere_bar = false

func _process(delta):
	verificar_distancia()


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
	luther.quiere_viajar = true


#esta puerta no existe
#func _on_salida_bar_pressed() -> void:
#	var distancia : int = $Luther.global_position.distance_to($"salida bar".global_position)
#	print(distancia)
#	if distancia < 220:
#		get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
		


func _on_salida_calle_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_salida_calle_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func verificar_distancia():
	if not luther.quiere_viajar:
		return
	if luther.quiere_viajar and quiere_bar == false:
		var distancia_salida_cjn : float = luther.global_position.distance_to(posicion_salida_cjn)
		if distancia_salida_cjn > 100:
			luther.ir_hacia_puerta(posicion_salida_cjn)
		else: # Esto equivale a <= 100
			get_tree().set_meta("posicion_inicial_luther", Vector2(2460, 500))
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
	if luther.quiere_viajar and quiere_bar == true:
		var distancia_salida_bar : float = luther.global_position.distance_to(posicion_salida_bar.global_position)
		if distancia_salida_bar > 100:
			luther.ir_hacia_puerta(posicion_salida_cjn)
		else: # Esto equivale a <= 100
			get_tree().set_meta("posicion_inicial_luther", Vector2(2790, 620))
			get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
			luther.quiere_viajar = false


func _on_salida_bar_pressed() -> void:
	luther.quiere_viajar = true
	quiere_bar = true


func _on_salida_bar_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_salida_bar_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
