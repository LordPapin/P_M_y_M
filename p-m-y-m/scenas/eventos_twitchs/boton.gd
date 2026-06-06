extends Node2D

signal prueba_superada
signal prueba_fallida

@export var duracion := 5.0

var clicks_actuales := 0
var clicks_objetivo := 10

var activa := false

@onready var timer := Timer.new()


func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)

	hide()


func iniciar_prueba(objetivo:int):

	clicks_objetivo = objetivo
	clicks_actuales = 0

	activa = true

	mostrar_color_rojo()

	show()

	timer.start(duracion)


func _input(event):

	if !activa:
		return

	if event is InputEventMouseButton:
		if event.pressed:

			clicks_actuales += 1

			actualizar_color()

			if clicks_actuales >= clicks_objetivo:

				activa = false

				timer.stop()

				mostrar_color_verde()

				prueba_superada.emit()

				hide()


func _on_timeout():

	if !activa:
		return

	activa = false

	prueba_fallida.emit()

	hide()


func actualizar_color():

	var progreso = float(clicks_actuales) / float(clicks_objetivo)

	if progreso >= 1.0:
		mostrar_color_verde()

	elif progreso >= 0.66:
		mostrar_color_amarillo()

	elif progreso >= 0.33:
		mostrar_color_naranja()

	else:
		mostrar_color_rojo()


func mostrar_color_rojo():
	modulate = Color.RED


func mostrar_color_naranja():
	modulate = Color.ORANGE


func mostrar_color_amarillo():
	modulate = Color.YELLOW


func mostrar_color_verde():
	modulate = Color.GREEN
