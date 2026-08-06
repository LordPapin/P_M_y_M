extends Node2D

@onready var luther: personaje = $Luther
@onready var calle_btn: TextureButton = $calle_btn
@onready var posicion_puerta: Node2D = $posicion



func _on_calle_btn_pressed() -> void:
	luther.quiere_viajar = true

func _process(delta):
	var distancia : int = luther.global_position.distance_to(posicion_puerta.global_position)
	if luther.quiere_viajar:
		if (distancia >100):
			luther.ir_hacia_puerta(posicion_puerta)
		if (distancia <=100):
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
