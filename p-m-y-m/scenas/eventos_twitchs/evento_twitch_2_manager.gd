extends CanvasLayer

@onready var luther = $Luther

@onready var mapache: Sprite2D = $LauchaMapache/Sprite2D
@onready var laucha: Sprite2D = $LauchaMapache/Sprite2D2

@onready var pixel_art_1: Sprite2D = $PixelArtYellowWarningSignWithExclamationMarkIconPng
@onready var pixel_art_2: Sprite2D = $PixelArtYellowWarningSignWithExclamationMarkIconPng2

@onready var camara_dialogo: Camera2D = $CameraDialogo

@onready var grafiti1 = $Grafitis/grafiti1
@onready var grafiti2 = $Grafitis/grafiti2
@onready var grafiti3 = $Grafitis/grafiti3

@onready var laucha_mapache = $LauchaMapache
@onready var boton = $Boton

@onready var pantalla_derrota = $pantalla_reintentar
@onready var reintentar_btn = $pantalla_reintentar/reintentar_btn
var dialogo = load("res://dialogos/escucha_laucha_mapache.dialogue")

var posicion_inicial_luther : Vector2

var fase_actual := 0

var objetivos = [
	10,
	15,
	20
]

func _ready():
	posicion_inicial_luther = luther.global_position
	luther.grafiti_alcanzado.connect(_on_grafiti_alcanzado)
	
	laucha_mapache.inicio_vigilancia.connect(_on_inicio_vigilancia)
	boton.prueba_superada.connect(_on_prueba_superada)
	boton.prueba_fallida.connect(_on_prueba_fallida)
	
	pantalla_derrota.hide()
	
	iniciar_minijuego()
	


func iniciar_minijuego():
	luther.global_position = posicion_inicial_luther
	pantalla_derrota.hide()
	fase_actual = 0
	luther.cambiar_estado("caminando")
	luther.ir_a_grafiti(grafiti1, 0)
	laucha_mapache.iniciar_patron()


func _on_grafiti_alcanzado(indice):
	print("Llegó al grafiti ", indice)


func _on_inicio_vigilancia():
	if fase_actual >= 3:
		return
		
	luther.cambiar_estado("invisible")
	boton.iniciar_prueba(objetivos[fase_actual])
	laucha.flip_h = true
	mapache.global_position = Vector2(1136,475)
	pixel_art_1.visible = true
	pixel_art_2.visible = true
	


func _on_prueba_superada():
	laucha_mapache.terminar_vigilancia()
	luther.cambiar_estado("respirando")
	laucha.flip_h = false
	mapache.global_position = Vector2(1136,572)
	pixel_art_1.visible = false
	pixel_art_2.visible = false
	fase_actual += 1
	match fase_actual:
		1:
			luther.ir_a_grafiti(grafiti2, 1)
		2:
			luther.ir_a_grafiti(grafiti3, 2)
		3:
			_on_finalizar()


func _on_prueba_fallida():
	laucha_mapache.terminar_vigilancia()
	luther.cambiar_estado("visible")
	laucha_mapache.cambiar_estado("alertados")


func _on_alertados():
	luther.destino = null
	luther.velocity = Vector2.ZERO
	
	pantalla_derrota.show()


func eliminar():
	queue_free()


func _on_finalizar() -> void:
	luther.cambiar_estado("aliviado")
	print("MINIJUEGO SUPERADO")

	# Posición entre la Laucha y el Mapache
	var punto_medio = (
		laucha_mapache.global_position +
		mapache.global_position
	) / 2.0

	# Encendemos la cámara
	camara_dialogo.enabled = true

	# La colocamos entre ambos
	camara_dialogo.global_position = punto_medio
	punto_medio = punto_medio - Vector2(0, 200)

	# Zoom suave
	var tween = create_tween()
	tween.tween_property(
		camara_dialogo,
		"zoom",
		Vector2(2, 2),
		0.6
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await tween.finished

	# Esperamos 2 segundos antes del diálogo
	await get_tree().create_timer(2.0).timeout

	# Ahora sí comienza el diálogo
	DialogueManager.show_dialogue_balloon(dialogo)

	await DialogueManager.dialogue_ended

	get_tree().call_group("nivel_3", "quitar_pausa")

	if NPCstates.npcs["npc_pescador"]["current_state"] == "sobrio_sin_info_no_conversado":
		NPCstates.npcs["npc_pescador"]["current_state"] = "sobrio_con_info_no_conversado"

	if NPCstates.npcs["npc_pescador"]["current_state"] == "sobrio_sin_info_conversado":
		NPCstates.npcs["npc_pescador"]["current_state"] = "sobrio_con_info_conversado"

	if NPCstates.npcs["npc_pescador"]["current_state"] == "borracho_sin_info":
		NPCstates.npcs["npc_pescador"]["current_state"] = "borracho_con_info_sin_ayuda_conversado"
		
	if NPCstates.npcs["npc_pescador"]["current_state"] == "borracho_sin_info_conversado":
		NPCstates.npcs["npc_pescador"]["current_state"] = "borracho_con_info_sin_ayuda_conversado"
		
	eliminar()


func _on_reintentar_btn_pressed() -> void:
	iniciar_minijuego()
