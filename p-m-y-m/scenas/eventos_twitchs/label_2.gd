extends Label

@export var duracion_parpadeo: float = 1.5

func _ready() -> void:
	# Comprobamos si el jugador ya vio este tutorial
	print("¿Tutorial de calle visto?: ", NPCstates.tutorial_calle_visto)

	# Si todavía no lo vio, mostramos el Label
	visible = true

	# Iniciamos el parpadeo
	iniciar_parpadeo_suave()

func iniciar_parpadeo_suave() -> void:
	var tween = create_tween()

	tween.set_loops()

	# Cambiamos 0.4 por 1.5 segundos para que desaparezca lentamente
	tween.tween_property(
		self,
		"modulate:a",
		0.2,
		1.5
	).set_trans(Tween.TRANS_SINE)

	# Cambiamos 0.4 por 1.5 segundos para que reaparezca lentamente
	tween.tween_property(
		self,
		"modulate:a",
		1.0,
		1.5
	).set_trans(Tween.TRANS_SINE)
