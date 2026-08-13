extends Area2D
signal atrapado 

@onready var animacion = $animacion
# Esta señal avisará cuando el pez sume un punto

func _ready():
	# Añadimos el pez a un grupo para que la lengua pueda reconocerlo fácilmente
	add_to_group("peces")
	animacion.play("anim")
	animar_salto()

func animar_salto():
	# Creamos el Tween
	var tween = create_tween()
	
	var altura_salto = position.y - 300 # Sube 300 píxeles
	var posicion_caida = position.y + 100 # Cae por debajo de su punto de inicio
	var duracion = 0.6 # Segundos que tarda en subir/bajar

	# Animación de subida (frena al llegar arriba)
	tween.tween_property(self, "position:y", altura_salto, duracion)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
		
	# Animación de caída (acelera hacia abajo)
	tween.tween_property(self, "position:y", posicion_caida, duracion)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
	
	# Cuando el Tween termina toda la secuencia, llamamos a la función de desaparecer
	tween.finished.connect(_on_caida_terminada)

func _on_caida_terminada():
	# Si el pez termina su salto y nadie lo tocó, se elimina
	queue_free()

# Esta función la llamará la lengua del camaleón cuando lo golpee
func ser_atrapado():
	atrapado.emit() # Avisamos al Manager para sumar el punto
	# (Opcional) Aquí podrías instanciar partículas o un sonido de "¡Ñam!"
	queue_free() # El pez desaparece de la escena
