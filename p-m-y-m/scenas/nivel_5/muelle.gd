extends Node2D


#conseguimos referencia a Luther
@onready var luther: personaje = $Luther

#conseguimos referencia a puertas
@onready var calle_btn: TextureButton = $calle
@onready var tienda_btn: TextureButton = $tienda

#conseguimos referencia a la posicion de las puertas(un nodo 2D personalizado)
@onready var posicion_calle = $posicion_calle.global_position
@onready var posicion_tienda = $posicion_tienda.global_position

#usamos booleanos para controlar hacia donde quiere viajar el jugador
#serán manejadas por las señales de botones presionados
var quiere_calle = false
var quiere_tienda = false


func _process(delta):
	verificar_distancia()



func _on_calle_pressed() -> void:
	luther.quiere_viajar = true
	quiere_calle = true


func _on_tienda_pressed() -> void:
	luther.quiere_viajar = true
	quiere_tienda = true
		
func visible():
	$npc_pescador.visible = true
	pass


func _on_calle_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_calle_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_tienda_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_tienda_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func verificar_distancia():
	# 1. Si no quiere viajar, limpiamos variables y cortamos la ejecución aquí mismo.
	if not luther.quiere_viajar:
		quiere_calle = false
		quiere_tienda = false
		
		
	if quiere_calle:
		var distancia_calle : float = luther.global_position.distance_to(posicion_calle)
		if distancia_calle > 100:
			luther.ir_hacia_puerta(posicion_calle)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
			
	if quiere_tienda:
		var distancia_tienda : float = luther.global_position.distance_to(posicion_tienda)
		if distancia_tienda > 100:
			luther.ir_hacia_puerta(posicion_tienda)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_5/tienda_muelle.tscn")
			luther.quiere_viajar = false
			
			
			
			
			
			
			
			
			
			
			
			
			
