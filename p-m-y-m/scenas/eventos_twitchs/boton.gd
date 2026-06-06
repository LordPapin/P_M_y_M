extends Node2D

signal prueba_superada
signal prueba_fallida

@export var duracion := 5.0

var activa := false

var clicks_actuales := 0
var clicks_objetivo := 10

@onready var sprite = $Sprite2D
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

	sprite.modulate = Color.RED

	show()

	timer.start(duracion)


func _input(event):

	if !activa:
		return

	if event is InputEventMouseButton and event.pressed:

		clicks_actuales += 1

		actualizar_color()

		if clicks_actuales >= clicks_objetivo:

			activa = false

			timer.stop()

			sprite.modulate = Color.GREEN

			hide()

			prueba_superada.emit()


func _on_timeout():

	if !activa:
		return

	activa = false

	hide()

	prueba_fallida.emit()


func actualizar_color():

	var progreso = float(clicks_actuales) / float(clicks_objetivo)

	if progreso >= 1.0:

		sprite.modulate = Color.GREEN

	elif progreso >= 0.66:

		sprite.modulate = Color.YELLOW

	elif progreso >= 0.33:

		sprite.modulate = Color.ORANGE

	else:

		sprite.modulate = Color.RED
