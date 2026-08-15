extends Label

@export var duracion_parpadeo: float = 1.5


func _ready() -> void:
	# Este Label debe seguir funcionando aunque el juego esté pausado
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	visible = true
	
	iniciar_parpadeo_suave()


func iniciar_parpadeo_suave() -> void:
	var tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(
		self,
		"modulate:a",
		0.2,
		duracion_parpadeo
	).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(
		self,
		"modulate:a",
		1.0,
		duracion_parpadeo
	).set_trans(Tween.TRANS_SINE)
