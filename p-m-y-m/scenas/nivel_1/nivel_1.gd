extends Node2D

@onready var luther: personaje = $Luther
@onready var calle_btn: TextureButton = $calle_btn
@onready var posicion_puerta: Node2D = $posicion
@onready var posicion_escritorio: Node2D = $posicion_escritorio
@onready var escritorio_btn: TextureButton = $escritorio_btn

var luther_escritorio = false
var luther_calle = false



func _on_calle_btn_pressed() -> void:
	luther.quiere_viajar = true

func _process(delta):
	var distancia : int = luther.global_position.distance_to(posicion_puerta.global_position)
	var distancia_escritorio : int = luther.global_position.distance_to(posicion_escritorio.global_position)
	if luther.quiere_viajar and luther.quiere_escritorio == false:
		if (distancia >100):
			luther.ir_hacia_puerta(posicion_puerta.global_position)
		if (distancia <=100):
			get_tree().set_meta("posicion_inicial_luther", Vector2(700, 430))
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
	if luther.quiere_viajar and luther.quiere_escritorio == true:
		if (distancia_escritorio >100):
			luther.ir_hacia_puerta(posicion_escritorio.global_position)
		if (distancia_escritorio <=100):
			get_tree().change_scene_to_file("res://scenas/nivel_1/escritorio_full.tscn")
			luther.quiere_viajar = false
			luther.quiere_escritorio = false
	if luther_escritorio == true:
		luther.global_position = Vector2(917, 617)
		luther_escritorio = false


func _on_escritorio_btn_pressed() -> void:
	luther.quiere_viajar = true
	luther.quiere_escritorio = true
