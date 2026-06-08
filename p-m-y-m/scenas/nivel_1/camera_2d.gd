extends Camera2D

func _ready() -> void:
	# Límite en el eje X (Horizontal)
	limit_left = 0
	limit_right = 1536 # Redondeado de 1535.75
	
	# Límite en el eje Y (Vertical)
	limit_top = 0
	limit_bottom = 326
	
	# Aseguramos que la cámara sea la cámara activa del juego
	make_current()
