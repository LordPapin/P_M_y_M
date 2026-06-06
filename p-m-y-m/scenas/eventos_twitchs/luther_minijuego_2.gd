extends CharacterBody2D

signal grafiti_alcanzado(indice)

@export var velocidad := 50.0

var estado_actual := "no_advertido"

var grafiti_actual := -1
var destino: Marker2D = null

@onready var grafitis := [
	$"grafiti 1",
	$"grafiti 2",
	$"grafiti 3"
]

func _physics_process(delta):

	if destino == null:
		return

	var direccion := global_position.direction_to(destino.global_position)

	velocity = direccion * velocidad

	move_and_slide()

	if global_position.distance_to(destino.global_position) < 5:

		global_position = destino.global_position
		velocity = Vector2.ZERO

		grafiti_actual += 1

		destino = null

		grafiti_alcanzado.emit(grafiti_actual)


func ir_a_grafiti(indice:int):

	if indice < 0:
		return

	if indice >= grafitis.size():
		return

	destino = grafitis[indice]


func cambiar_estado(nuevo_estado:String):

	estado_actual = nuevo_estado

	match estado_actual:
		"no_advertido":
			print("Luther no fue advertido")
		"advertido":
			print("Luther fue advertido")
		"caminando":
			print("Luther camina")
		"invisible":
			print("Luther se oculta")
		"respirando":
			print("Luther respira")
		"aliviado":
			print("Luther está aliviado")


func obtener_estado() -> String:
	return estado_actual
