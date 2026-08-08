extends Node2D
#conseguimos referencia a Luther
@onready var luther: personaje = $Luther

#conseguimos referencia a puertas
@onready var bar_btn: TextureButton = $puerta_bar
@onready var callejon_btn: TextureButton = $callejon_btn
@onready var muelle_btn: TextureButton = $muelle_btn
@onready var banco_btn: TextureButton = $banco_tbn
@onready var oficina_btn: TextureButton = $oficina_btn

#conseguimos referencia a la posicion de las puertas(un nodo 2D personalizado)
@onready var posicion_bar = $posicion_bar.global_position
@onready var posicion_callejon = $posicion_callejon.global_position
@onready var posicion_muelle = $posicion_muelle.global_position
@onready var posicion_banco = $posicion_banco.global_position
@onready var posicion_oficina = $posicion_oficina.global_position

#usamos booleanos para controlar hacia donde quiere viajar el jugador
#serán manejadas por las señales de botones presionados
var quiere_bar = false
var quiere_callejon = false
var quiere_muelle = false
var quiere_banco = false
var quiere_oficina = false


func _process(delta):
	verificar_distancia()


#a través de las señales de las puertas, definimos QUÉ quiere Luther y a DÓNDE
func _on_puerta_bar_pressed() -> void:
	luther.quiere_viajar = true
	quiere_bar = true

func _on_callejon_btn_pressed() -> void:
	luther.quiere_viajar = true
	quiere_callejon = true

func _on_muelle_btn_pressed() -> void:
	luther.quiere_viajar = true
	quiere_muelle = true

func _on_banco_tbn_pressed() -> void:
	luther.quiere_viajar = true
	quiere_banco = true

func _on_oficina_btn_pressed() -> void:
	luther.quiere_viajar = true
	quiere_oficina = true


######################################################################


#SEÑALES DE DECORACIÓN PARA LA ANIMACIÓN DEL CURSOR
func _on_puerta_bar_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)

func _on_puerta_bar_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_callejon_btn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_callejon_btn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()

func _on_muelle_btn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_muelle_btn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_banco_tbn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_banco_tbn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_oficina_btn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_oficina_btn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()




func verificar_distancia():
	# 1. Si no quiere viajar, limpiamos variables y cortamos la ejecución aquí mismo.
	if not luther.quiere_viajar:
		quiere_bar = false
		quiere_callejon = false
		quiere_muelle = false
		quiere_banco = false
		quiere_oficina = false
		return # El 'return' hace que la función se detenga aquí. ¡Ahorramos cálculos!

	# 2. Si llegamos aquí, ES PORQUE quiere viajar. 
	# Calculamos SOLAMENTE la distancia del destino elegido usando elif.
	
	if quiere_bar:
		var distancia_bar : float = luther.global_position.distance_to(posicion_bar)
		if distancia_bar > 100:
			luther.ir_hacia_puerta(posicion_bar)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
			luther.quiere_viajar = false
			
	elif quiere_callejon:
		var distancia_callejon: float = luther.global_position.distance_to(posicion_callejon)
		if distancia_callejon > 100:
			luther.ir_hacia_puerta(posicion_callejon)
		else:
			get_tree().change_scene_to_file("res://scenas/nivel_4/callejon.tscn")
			luther.quiere_viajar = false
			
	elif quiere_muelle:
		var distancia_muelle : float = luther.global_position.distance_to(posicion_muelle)
		if distancia_muelle > 100:
			luther.ir_hacia_puerta(posicion_muelle)
		else:
			get_tree().change_scene_to_file("res://scenas/nivel_5/muelle.tscn")
			luther.quiere_viajar = false
			
	elif quiere_banco:
		var distancia_banco : float = luther.global_position.distance_to(posicion_banco)
		if distancia_banco > 100:
			luther.ir_hacia_puerta(posicion_banco)
		else:
			get_tree().change_scene_to_file("res://scenas/nivel_6/banco.tscn")
			luther.quiere_viajar = false
			
	elif quiere_oficina:
		var distancia_oficina : float = luther.global_position.distance_to(posicion_oficina)
		if distancia_oficina > 100:
			luther.ir_hacia_puerta(posicion_oficina)
		else:
			get_tree().change_scene_to_file("res://scenas/nivel_1/nivel_1.tscn")
			luther.quiere_viajar = false
