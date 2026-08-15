extends Area2D

signal atrapado

@onready var animacion = $animacion


# ============================================================
# VELOCIDAD
# ============================================================

var velocidad: float = 100.0

const VELOCIDAD_BASE: float = 100.0

var tween_salto: Tween


# ============================================================
# INICIO
# ============================================================

func _ready():

	add_to_group("piranias")

	animacion.play("anim")

	animar_salto()


# ============================================================
# ANIMACIÓN DEL SALTO
# ============================================================

func animar_salto():

	# Si ya existe un Tween, lo eliminamos
	if tween_salto and tween_salto.is_valid():
		tween_salto.kill()

	tween_salto = create_tween()

	var altura_salto = position.y - 300
	var posicion_caida = position.y + 100

	# La misma fórmula que usamos para los peces
	var duracion = 0.6 * (VELOCIDAD_BASE / velocidad)


	# --------------------------------------------------------
	# SUBIDA
	# --------------------------------------------------------

	tween_salto.tween_property(
		self,
		"position:y",
		altura_salto,
		duracion
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


	# --------------------------------------------------------
	# CAÍDA
	# --------------------------------------------------------

	tween_salto.tween_property(
		self,
		"position:y",
		posicion_caida,
		duracion
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


	tween_salto.finished.connect(_on_caida_terminada)


# ============================================================
# CAMBIAR VELOCIDAD
# ============================================================

func cambiar_velocidad(nueva_velocidad: float):

	velocidad = nueva_velocidad

	# Reiniciamos el movimiento con la nueva velocidad
	animar_salto()


# ============================================================
# TERMINÓ EL SALTO
# ============================================================

func _on_caida_terminada():

	queue_free()


# ============================================================
# ATRAPADO
# ============================================================

func ser_atrapado():

	# Avisamos al manager
	atrapado.emit()

	# Eliminamos la piraña
	queue_free()
