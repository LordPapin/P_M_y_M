extends Node2D
#muelle

#conseguimos referencia a Luther
@onready var luther: personaje = $Luther
@onready var npc_pescador = $npc_pescador

#conseguimos referencia a puertas
@onready var calle_btn: TextureButton = $calle
@onready var tienda_btn: TextureButton = $tienda

#conseguimos referencia a la posicion de las puertas(un nodo 2D personalizado)
@onready var posicion_calle = $posicion_calle.global_position
@onready var posicion_tienda = $posicion_tienda.global_position
@onready var minijuego3 = preload("res://scenas/eventos_twitchs/Evento_twitch_3.tscn")

#usamos booleanos para controlar hacia donde quiere viajar el jugador
#serán manejadas por las señales de botones presionados
var quiere_calle = false
var quiere_tienda = false



func _ready() -> void:
	if get_tree().has_meta("posicion_inicial_luther"):
		luther.global_position = get_tree().get_meta("posicion_inicial_luther")
		get_tree().remove_meta("posicion_inicial_luther")

func _process(delta):
	verificar_distancia()



func _on_calle_pressed() -> void:
	luther.quiere_viajar = true
	quiere_calle = true


func _on_tienda_pressed() -> void:
	luther.quiere_viajar = true
	quiere_tienda = true
		
func visible():
	npc_pescador.visible = true
	pass


func _on_calle_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_calle_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_tienda_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_tienda_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func verificar_distancia():
	# 1. Si no quiere viajar, limpiamos variables y cortamos la ejecución aquí mismo.
	if not luther.quiere_viajar:
		quiere_calle = false
		quiere_tienda = false
		
		
	if quiere_calle:
		var distancia_calle : float = luther.global_position.distance_to(posicion_calle)
		if distancia_calle > 100:
			luther.ir_hacia_puerta(posicion_calle)
		else: # Esto equivale a <= 100
			get_tree().set_meta("posicion_inicial_luther", Vector2(200, 400))
			get_tree().change_scene_to_file("res://scenas/nivel_3/calle.tscn")
			luther.quiere_viajar = false
			
	if quiere_tienda:
		var distancia_tienda : float = luther.global_position.distance_to(posicion_tienda)
		if distancia_tienda > 100:
			luther.ir_hacia_puerta(posicion_tienda)
		else: # Esto equivale a <= 100
			get_tree().change_scene_to_file("res://scenas/nivel_5/tienda_muelle.tscn")
			luther.quiere_viajar = false
			


func _on_npc_pescador_comenzar_minijuego() -> void:
	# 1. Creamos una instancia real de la escena y la guardamos en una variable
	var instancia_minijuego = minijuego3.instantiate()
	instancia_minijuego.process_mode = Node.PROCESS_MODE_ALWAYS
	instancia_minijuego.Ganado.connect(_on_minijuego_ganado)
	npc_pescador.process_mode = Node.PROCESS_MODE_DISABLED
	# 2. Añadimos esa instancia como hijo a la escena actual
	add_child(instancia_minijuego)


func _on_minijuego_ganado():
	npc_pescador.process_mode = Node.PROCESS_MODE_INHERIT
	NPCstates.npcs["npc_pescador"]["current_state"] = "borracho_con_info_con_ayuda"
	
	# 2. Iniciamos la conversación automáticamente para darle la recompensa
	npc_pescador.iniciar_dialogo()
