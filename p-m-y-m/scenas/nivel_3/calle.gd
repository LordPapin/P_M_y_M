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
@onready var posicion_bar: Node2D = $posicion_bar
@onready var posicion_callejon: Node2D = $posicion_callejon
@onready var posicion_muelle: Node2D = $posicion_muelle
@onready var posicion_banco: Node2D = $posicion_banco
@onready var posicion_oficina: Node2D = $posicion_oficina

#usamos booleanos para controlar hacia donde quiere viajar el jugador
#serán manejadas por las señales de botones presionados
var quiere_bar = false
var quiere_callejon = false
var quiere_muelle = false
var quiere_banco = false
var quiere_oficina = false

######################################################################

func _process(delta):
	#usamos variables que calculan la distancia entre Luther y las puertas
	var distancia_bar : int = luther.global_position.distance_to(posicion_bar.global_position)
	var distancia_callejon : int = luther.global_position.distance_to(posicion_callejon.global_position)
	var distancia_muelle : int = luther.global_position.distance_to(posicion_muelle.global_position)
	var distancia_banco : int = luther.global_position.distance_to(posicion_banco.global_position)
	var distancia_oficina : int = luther.global_position.distance_to(posicion_oficina.global_position)
	
	######################################################################
	
	
	
	if luther.quiere_viajar: #como quiere viajar (presionó un botón de puerta), le preguntamos a dónde
		
		if quiere_bar:
			if (distancia_bar >100):
				luther.ir_hacia_puerta(posicion_bar)
			if (distancia_bar <=100):
				get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")
				luther.quiere_viajar = false
			
		if quiere_callejon:
			if (distancia_callejon >100):
				luther.ir_hacia_puerta(posicion_callejon)
			if (distancia_callejon <=100):
				get_tree().change_scene_to_file("res://scenas/nivel_4/callejon.tscn")
				luther.quiere_viajar = false
			
		if quiere_muelle:
			if (distancia_muelle >100):
				luther.ir_hacia_puerta(posicion_muelle)
			if (distancia_muelle <=100):
				get_tree().change_scene_to_file("res://scenas/nivel_5/muelle.tscn")
				luther.quiere_viajar = false
			
		if quiere_banco:
			if (distancia_banco >100):
				luther.ir_hacia_puerta(posicion_banco)
			if (distancia_banco <=100):
				get_tree().change_scene_to_file("res://scenas/nivel_6/banco.tscn")
				luther.quiere_viajar = false
			
		if quiere_oficina:
			if (distancia_oficina >100):
				luther.ir_hacia_puerta(posicion_oficina)
			if (distancia_oficina <=100):
				get_tree().change_scene_to_file("res://scenas/nivel_1/nivel_1.tscn")
				luther.quiere_viajar = false
		
	else:#si no quiere viajar, entonces no quiere ir a NINGUN lado
		quiere_bar = false
		quiere_callejon = false
		quiere_muelle = false
		quiere_banco = false
		quiere_oficina = false

######################################################################


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
