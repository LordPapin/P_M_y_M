extends Node

# Cargamos la escena de tu cursor en memoria
var cursor_scene: PackedScene = preload("res://scenas/punteros/punteros.tscn") # Ajusta la ruta a tu escena

# Aquí guardaremos la referencia al cursor vivo
var instancia_cursor: Node2D = null

func _ready():
	# 1. Creamos un CanvasLayer dinámicamente para que el cursor 
	# siempre se dibuje por encima de la interfaz y mapas.
	var capa_canvas = CanvasLayer.new()
	capa_canvas.layer = 128 # Una capa muy alta para asegurar que esté arriba de todo
	add_child(capa_canvas)
	
	# 2. Instanciamos tu cursor y lo añadimos a esa capa
	instancia_cursor = cursor_scene.instantiate()
	capa_canvas.add_child(instancia_cursor)

# Funciones globales para controlar el cursor desde cualquier script del juego:

func cambiar_bloqueo(estado: bool):
	if instancia_cursor:
		instancia_cursor.bloqueado = estado

func forzar_animacion(nombre_anim: String):
	if instancia_cursor:
		instancia_cursor.animacion_forzada = nombre_anim

# Función para conectar de forma segura la señal "accion_disparada" desde otros scripts
func conectar_accion(objetivo: Object, metodo: String):
	if instancia_cursor:
		instancia_cursor.accion_disparada.connect(Callable(objetivo, metodo))
