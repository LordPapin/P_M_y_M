extends Label


func _ready() -> void:
	# Comprobamos si el jugador ya vio este tutorial
	print("¿Tutorial de calle visto?: ", NPCstates.tutorial_calle_visto)

	if NPCstates.tutorial_calle_visto:
		visible = false
		queue_free()
		return

	# Si todavía no lo vio, mostramos el Label
	visible = true

	# Iniciamos el parpadeo
	iniciar_parpadeo_suave()

	# Después de 5 segundos marcamos el tutorial como visto
	get_tree().create_timer(5.0).timeout.connect(on_tiempo_expirado)


func iniciar_parpadeo_suave() -> void:
	var tween = create_tween()

	tween.set_loops()

	tween.tween_property(
		self,
		"modulate:a",
		0.2,
		0.4
	).set_trans(Tween.TRANS_SINE)

	tween.tween_property(
		self,
		"modulate:a",
		1.0,
		0.4
	).set_trans(Tween.TRANS_SINE)


func on_tiempo_expirado() -> void:
	# Marcamos el tutorial como visto GLOBALMENTE
	NPCstates.tutorial_calle_visto = true

	print("Tutorial de calle marcado como visto")

	# Eliminamos el Label
	queue_free()
