extends Area2D

# Esta función se genera automáticamente al conectar la señal
func _on_body_entered(body: Node2D) -> void:
	# Verificamos si el cuerpo que entró está en el grupo "jugador"
	if body.is_in_group("jugador"):
		
		# Llamamos a una función específica dentro del script del jugador
		if body.has_method("recibir_aviso_del_area"):
			body.recibir_aviso_del_area()
			
		# Eliminamos el objeto Area2D de la escena de forma segura
		queue_free()
