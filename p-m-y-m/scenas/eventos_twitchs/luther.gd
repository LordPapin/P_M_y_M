extends Node2D

@onready var boca = $boca
@onready var lengua = $lengua
@onready var punta = $PuntaLengua
@onready var luther_sprite: AnimatedSprite2D = $lutherSprite


# ============================================================
# CONFIGURACIÓN DE LA LENGUA
# ============================================================

@export var velocidad_lengua: float = 0.1


# ============================================================
# ESTADO
# ============================================================

var animado: bool = false


# ============================================================
# READY
# ============================================================

func _ready() -> void:

	luther_sprite.play("idle")


# ============================================================
# INPUT
# ============================================================

func _input(event):

	if event.is_action_pressed("dispararLengua") and not animado:

		disparar_lengua(get_global_mouse_position())


# ============================================================
# ACTUALIZAR LENGUA
# ============================================================

func _process(_delta):

	lengua.clear_points()

	lengua.add_point(
		lengua.to_local(boca.global_position)
	)

	lengua.add_point(
		lengua.to_local(punta.global_position)
	)


# ============================================================
# DISPARAR LENGUA
# ============================================================

func disparar_lengua(target_pos):

	animado = true

	lengua.visible = true
	punta.visible = true

	punta.global_position = boca.global_position


	# Crear Tween
	var tween = create_tween()


	# ========================================================
	# SACAR LENGUA
	# ========================================================

	tween.tween_property(
		punta,
		"global_position",
		target_pos,
		velocidad_lengua
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


	# ========================================================
	# VOLVER LENGUA
	# ========================================================

	tween.tween_property(
		punta,
		"global_position",
		boca.global_position,
		velocidad_lengua
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


	# ========================================================
	# TERMINÓ
	# ========================================================

	tween.tween_callback(anim_lengua_finalizada)


# ============================================================
# FINALIZAR ANIMACIÓN
# ============================================================

func anim_lengua_finalizada():

	animado = false

	lengua.visible = false
	punta.visible = false
