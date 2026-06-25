extends Control

@export var imagen : Array[Texture2D]  = []
@export var tiempo_transicion = 1.0

var indice_actual : int = 0
@onready var display = $display
@onready var timer = $Timer
@onready var continuar_btn = $continuar_btn

func _ready() -> void:
	if imagen.size() > 0:
		display.texture = imagen[0]
		timer.timeout.connect(_on_timer_timeout)
	else:
		push_error("no hay imagenes")
	continuar_btn.visible = false



func _on_timer_timeout():
	pasar_siguiente_imagen()


func pasar_siguiente_imagen():
	var tween = create_tween()
	await tween.tween_property(display, "modulate:a", 0.0, tiempo_transicion/ 2).finished
	
	indice_actual +=1
	if indice_actual < imagen.size():
		display.texture = imagen[indice_actual]
	else:
		continuar_btn.visible = true
		timer.stop()
		return
	
	var tween_entrada = create_tween()
	tween_entrada.tween_property(display, "modulate:a", 1.0, tiempo_transicion/2)



func _input(event):
	if event is InputEventMouseButton and event.pressed:
		timer.start() 
		pasar_siguiente_imagen()


func _on_continuar_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenas/nivel_1/nivel_1.tscn")
