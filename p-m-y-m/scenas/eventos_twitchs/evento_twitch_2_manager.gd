extends Node2D

@onready var luther = $Luther
@onready var laucha_mapache = $LauchaMapache
@onready var boton = $Boton

var fase_actual := 0

var clicks_por_fase = [
	10,
	15,
	20
]

func _ready():

	luther.grafiti_alcanzado.connect(_on_grafiti_alcanzado)

	laucha_mapache.inicio_vigilancia.connect(_on_inicio_vigilancia)
	laucha_mapache.fin_vigilancia.connect(_on_fin_vigilancia)
	laucha_mapache.alertados.connect(_on_alertados)

	boton.prueba_superada.connect(_on_prueba_superada)
	boton.prueba_fallida.connect(_on_prueba_fallida)


# ------------------------------------------------------------------
# ADVERTENCIA INICIAL
# ------------------------------------------------------------------

func jugador_se_acerca():

	if luther.estado_actual == "no_advertido":

		luther.cambiar_estado("advertido")

		# Abrir diálogo:
		# "Ignorar advertencia"
		# "Espiar sigilosamente"


func elegir_ignorar():

	# Si vuelve a acercarse:
	# Cinemática derrota

	pass


func elegir_sigilo():

	fase_actual = 0

	luther.cambiar_estado("caminando")

	luther.ir_a_grafiti(0)

	laucha_mapache.cambiar_estado("susurrando")


# ------------------------------------------------------------------
# LUTHER
# ------------------------------------------------------------------

func _on_grafiti_alcanzado(indice):

	print("Luther llegó al grafiti ", indice)

	# Esperamos a que LauchaMapache entre en vigilancia.
	# Cuando eso ocurra se disparará la prueba.


# ------------------------------------------------------------------
# LAUCHA Y MAPACHE
# ------------------------------------------------------------------

func _on_inicio_vigilancia():

	if fase_actual >= 3:
		return

	luther.cambiar_estado("invisible")

	boton.global_position = luther.global_position + Vector2(0, -80)

	boton.iniciar_prueba(
		clicks_por_fase[fase_actual]
	)


func _on_fin_vigilancia():

	if luther.estado_actual == "visible":

		laucha_mapache.cambiar_estado("alertados")


func _on_alertados():

	print("DERROTA")

	# Mostrar viñetas de derrota
	# Reiniciar escena o devolver al inicio


# ------------------------------------------------------------------
# BOTÓN
# ------------------------------------------------------------------

func _on_prueba_superada():

	luther.cambiar_estado("respirando")

	fase_actual += 1

	if fase_actual >= 3:

		finalizar_minijuego()

		return

	luther.ir_a_grafiti(fase_actual)


func _on_prueba_fallida():

	luther.cambiar_estado("visible")

	laucha_mapache.cambiar_estado("alertados")


# ------------------------------------------------------------------
# FINAL
# ------------------------------------------------------------------

func finalizar_minijuego():

	luther.cambiar_estado("aliviado")

	print("MINIJUEGO SUPERADO")

	# Conversación visible
	# Obtener información
	# Transición
	# Cargar escena posterior
