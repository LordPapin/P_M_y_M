extends Node2D

signal inicio_vigilancia
signal fin_vigilancia
signal alertados

@export var tiempo_susurro := 3.0

var estado_actual := "susurrando"

@onready var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)


func iniciar_patron():
	cambiar_estado("susurrando")


func cambiar_estado(nuevo_estado:String):
	estado_actual = nuevo_estado
	match estado_actual:
		"susurrando":
			print("Susurrando")
			fin_vigilancia.emit()
			timer.start(tiempo_susurro)
		"vigilando":
			print("Vigilando")
			inicio_vigilancia.emit()
		"alertados":
			print("Alertados")
			alertados.emit()


func terminar_vigilancia():
	cambiar_estado("susurrando")


func _on_timer_timeout():
	match estado_actual:
		"susurrando":
			cambiar_estado("vigilando")
		"vigilando":
			cambiar_estado("susurrando")
