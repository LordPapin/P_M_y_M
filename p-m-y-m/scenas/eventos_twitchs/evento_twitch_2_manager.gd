extends CanvasLayer

@onready var luther = $Luther

signal finalizar

@onready var grafiti1 = $Grafitis/grafiti1
@onready var grafiti2 = $Grafitis/grafiti2
@onready var grafiti3 = $Grafitis/grafiti3

@onready var laucha_mapache = $LauchaMapache
@onready var boton = $Boton

var dialogo = load("res://dialogos/escucha_laucha_mapache.dialogue")

var fase_actual := 0

var objetivos = [
	10,
	15,
	20
]

func _ready():

	luther.grafiti_alcanzado.connect(_on_grafiti_alcanzado)

	laucha_mapache.inicio_vigilancia.connect(_on_inicio_vigilancia)
	laucha_mapache.alertados.connect(_on_alertados)

	boton.prueba_superada.connect(_on_prueba_superada)
	boton.prueba_fallida.connect(_on_prueba_fallida)

	# SOLO PARA TEST
	iniciar_minijuego()
	print(grafiti1)
	print(grafiti2)
	print(grafiti3)

func iniciar_minijuego():

	fase_actual = 0

	luther.cambiar_estado("caminando")

	luther.ir_a_grafiti(grafiti1, 0)

	laucha_mapache.iniciar_patron()


func _on_grafiti_alcanzado(indice):

	print("Llegó al grafiti ", indice)


func _on_inicio_vigilancia():

	if fase_actual >= 3:
		return

	luther.cambiar_estado("invisible")

	boton.global_position = luther.global_position + Vector2(0, -80)

	boton.iniciar_prueba(objetivos[fase_actual])


func _on_prueba_superada():
	laucha_mapache.terminar_vigilancia()
	luther.cambiar_estado("respirando")
	fase_actual += 1
	match fase_actual:
		1:
			luther.ir_a_grafiti(grafiti2, 1)
		2:
			luther.ir_a_grafiti(grafiti3, 2)
		3:
			_on_finalizar()


func _on_prueba_fallida():
	laucha_mapache.terminar_vigilancia()
	luther.cambiar_estado("visible")
	laucha_mapache.cambiar_estado("alertados")


func _on_alertados():

	print("DERROTA")

	# Aquí pondrás las viñetas

func eliminar():
	queue_free()


func _on_finalizar() -> void:
	luther.cambiar_estado("aliviado")
	print("MINIJUEGO SUPERADO")
	DialogueManager.show_dialogue_balloon(dialogo)
	get_tree().call_group("nivel_3","quitar_pausa")
	eliminar()
