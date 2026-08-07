extends Node2D

@onready var luther: personaje = $Luther
@onready var calle_btn: TextureButton = $TextureButton
@onready var posicion_puerta = $posicion_puerta.global_position


func _on_calle_btn_pressed() -> void:
	luther.quiere_viajar = true

func _process(delta):
	var distancia = luther.global_position.distance_to(posicion_puerta)
	if luther.quiere_viajar:
		if (distancia >100):
			luther.ir_hacia_puerta(posicion_puerta)
		if (distancia <=100):
			get_tree().change_scene_to_file("res://scenas/nivel_6/banco.tscn")
			luther.quiere_viajar = false


func _on_texture_button_pressed() -> void:
	luther.quiere_viajar = true


func _on_texture_button_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_texture_button_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
