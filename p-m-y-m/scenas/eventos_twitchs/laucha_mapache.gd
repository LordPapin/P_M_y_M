extends Node2D

signal inicio_vigilancia
signal fin_vigilancia
signal alertados

@export var tiempo_susurro := 3.0
@export var tiempo_vigilancia := 2.0

var estado_actual := "susurrando"

@onready var timer := Timer.new()

func _ready():

	add_child(timer)

	timer.one_shot = true

	cambiar_estado("susurrando")


func cambiar_estado(nuevo_estado:String):

	estado_actual = nuevo_estado

	match estado_actual:

		"susurrando":

			print("Laucha y Mapache susurran")

			fin_vigilancia.emit()

			timer.start(tiempo_susurro)

		"vigilando":

			print("Laucha y Mapache vigilan")

			inicio_vigilancia.emit()

			timer.start(tiempo_vigilancia)

		"alertados":

			print("Laucha y Mapache detectaron a Luther")

			alertados.emit()


func _on_timer_timeout():

	match estado_actual:

		"susurrando":
			cambiar_estado("vigilando")

		"vigilando":
			cambiar_estado("susurrando")
