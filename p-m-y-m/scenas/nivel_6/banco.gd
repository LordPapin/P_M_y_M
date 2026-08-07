extends Node2D



@onready var luther: personaje = $Luther
@onready var calle_btn: TextureButton = $calle_btn
@onready var posicion_calle_btn = $posicion_calle_btn.global_position
@onready var puerta: TextureButton = $puerta
@onready var posicion_puerta = $posicion_puerta.global_position

func _on_calle_btn_pressed() -> void:
	luther.quiere_viajar = true
	
	
var quiere_calle = false
var quiere_banco = false

func _process(delta):
	verificar_distancia()

func _on_texture_button_pressed() -> void:
	luther.quiere_viajar = true
	quiere_banco = true


func _on_calle_tbn_pressed() -> void:
	luther.quiere_viajar = true
	quiere_calle = true


func _on_puerta_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_puerta_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_calle_tbn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_calle_tbn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func verificar_distancia():
	if not luther.quiere_viajar:
		quiere_calle = false
		quiere_banco = false
		
		
	if quiere_banco:
		var distancia_banco : float = luther.global_position.distance_to(posicion_puerta)
		if distancia_banco > 100:
			luther.ir_hacia_puerta(posicion_puerta)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_6/interior_banco.tscn")
			luther.quiere_viajar = false
			
	if quiere_calle:
		var distancia_calle : float = luther.global_position.distance_to(posicion_calle_btn)
		if distancia_calle > 100:
			luther.ir_hacia_puerta(posicion_calle_btn)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
