extends CharacterBody2D
class_name personaje

@export var speed: float = 300.0
@export var distancia_recoleccion := 400.0
@export var longitud_maxima := 12.0
@export var velocidad_lengua := 10.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimatedSprite2D = $animacion
@onready var lengua = $Lengua
@onready var cuerpo_lengua = $Lengua/CuerpoLengua
@onready var punta_lengua = $Lengua/PuntaLengua

@onready var camara: Camera2D = $Camera2D

var longitud_lengua := 1.0
var recurso_objetivo = null
var objeto_atrapado = null
var cayendo := false
var puerta_objetivo = null
var quiere_viajar = false
var quiere_escritorio = false

var npc_objetivo = null
var conversando := false

enum EstadoLengua { INACTIVA, EXTENDIENDO, RETRAYENDO }
var estado_lengua := EstadoLengua.INACTIVA
var recolectando := false

func _ready() -> void:
	lengua.visible = false
	animation_player.play("idle")
	for recurso in get_tree().get_nodes_in_group("recursos"):
		recurso.clicked.connect(seleccionar_recurso)

func _unhandled_input(event: InputEvent) -> void:
	if recolectando or conversando:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_movement_target(get_global_mouse_position())

func set_movement_target(target_point: Vector2):
	npc_objetivo = null
	recurso_objetivo = null
	nav_agent.target_position = target_point
	if quiere_viajar:
		quiere_viajar = false
		quiere_escritorio = false

func _physics_process(_delta: float) -> void:
	if recolectando:
		velocity = Vector2.ZERO
		move_and_slide()
		actualizar_animacion()
		return

	if npc_objetivo != null and is_instance_valid(npc_objetivo):
		var distancia_npc = global_position.distance_to(npc_objetivo.global_position)

		# Si ya estamos suficientemente cerca,
		# dejamos de caminar.
		if distancia_npc <= npc_objetivo.distancia_conversacion:
			velocity = Vector2.ZERO
			nav_agent.target_position = global_position
			move_and_slide()
			actualizar_animacion()
			return
	if recurso_objetivo != null and is_instance_valid(recurso_objetivo):
		var distancia = global_position.distance_to(recurso_objetivo.global_position)
		if distancia <= distancia_recoleccion:
			velocity = Vector2.ZERO
			iniciar_lengua()
			move_and_slide()
			actualizar_animacion()
			return

	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var next = nav_agent.get_next_path_position()
		velocity = (next - global_position).normalized() * speed

	move_and_slide()
	actualizar_animacion()

func _process(delta: float) -> void:
	# orientar la lengua
	if recurso_objetivo != null and is_instance_valid(recurso_objetivo):
		var dir = recurso_objetivo.global_position - lengua.global_position
		lengua.rotation = dir.angle()
	else:
		var dir = get_global_mouse_position() - lengua.global_position
		lengua.rotation = dir.angle()

	match estado_lengua:
		EstadoLengua.EXTENDIENDO:
			longitud_lengua = min(longitud_lengua + velocidad_lengua * delta, longitud_maxima)
			_aplicar_longitud()

			# hit por distancia: comparamos la punta con el recurso
			if recurso_objetivo != null and is_instance_valid(recurso_objetivo):
				var dist_punta = punta_lengua.global_position.distance_to(recurso_objetivo.global_position)
				if dist_punta < 40.0:
					objeto_atrapado = recurso_objetivo
					estado_lengua = EstadoLengua.RETRAYENDO

			# llegó al máximo sin golpear nada → retraer igual
			if longitud_lengua >= longitud_maxima and estado_lengua == EstadoLengua.EXTENDIENDO:
				estado_lengua = EstadoLengua.RETRAYENDO

		EstadoLengua.RETRAYENDO:
			longitud_lengua = max(longitud_lengua - velocidad_lengua * delta, 1.0)
			_aplicar_longitud()

			# arrastrar objeto si hay uno atrapado
			if objeto_atrapado != null:
				objeto_atrapado.global_position = punta_lengua.global_position

			if longitud_lengua <= 1.0:
				_finalizar_recoleccion()

func _aplicar_longitud() -> void:
	cuerpo_lengua.scale.x = longitud_lengua
	punta_lengua.position.x = 16.0 * longitud_lengua

func iniciar_lengua() -> void:
	if estado_lengua != EstadoLengua.INACTIVA:
		return
	recolectando = true
	longitud_lengua = 0.0
	estado_lengua = EstadoLengua.EXTENDIENDO
	lengua.visible = true

func _finalizar_recoleccion() -> void:
	estado_lengua = EstadoLengua.INACTIVA
	recolectando = false
	lengua.visible = false
	if objeto_atrapado != null and is_instance_valid(objeto_atrapado):
		if Inventory.add_item(objeto_atrapado.item_data):
			objeto_atrapado.queue_free()
	objeto_atrapado = null
	recurso_objetivo = null
	nav_agent.target_position = global_position

func actualizar_animacion() -> void:
	# Si el personaje está cayendo, abortamos esta función para no pisar la animación
	if cayendo:
		return

	# Obtenemos la velocidad real a la que se desplazó el cuerpo tras chocar
	var velocidad_real = get_real_velocity()

	# Usamos un pequeño margen de tolerancia (ej: 10.0) en vez de 0 
	# para ignorar la micro-fricción contra las paredes
	if velocidad_real.length() > 10.0:
		if abs(velocidad_real.y) > abs(velocidad_real.x):
			animation_player.play("walk_up" if velocidad_real.y < 0 else "walk")
		else:
			animation_player.play("walk")
			animation_player.flip_h = velocidad_real.x < 0
	else:
		animation_player.play("idle")

func seleccionar_recurso(recurso) -> void:
	if recolectando:
		return
	recurso_objetivo = recurso
	nav_agent.target_position = recurso.global_position
	
func recibir_aviso_del_area() -> void:
	# Bloqueamos las otras animaciones
	cayendo = true 
	
	# Opcional: frenar al personaje para que no patine mientras cae
	velocity = Vector2.ZERO 
	
	# 1. Reproducimos la animación
	animation_player.play("caida")
	
	# 2. Esperamos a que termine
	await animation_player.animation_finished
	
	# 3. Liberamos el bloqueo y volvemos a idle
	cayendo = false
	animation_player.play("idle")

func ir_hacia_puerta(puerta):
	puerta_objetivo = puerta
	nav_agent.target_position = puerta


func ir_hacia_npc(npc):
	npc_objetivo = npc
	recurso_objetivo = null
	puerta_objetivo = null
	quiere_viajar = false
	quiere_escritorio = false
	nav_agent.target_position = npc.global_position
	
	
func iniciar_conversacion(npc):
	if conversando:
		return
	
	if npc_objetivo != null and npc_objetivo != npc:
		return
	
	conversando = true
	npc_objetivo = null
	velocity = Vector2.ZERO
	nav_agent.target_position = global_position
	
	enfocar_conversacion(npc)
	
	npc.iniciar_dialogo()
	
func terminar_conversacion() -> void:
	conversando = false
	restaurar_camara()


func enfocar_conversacion(npc: Node2D) -> void:
	var punto_medio = (global_position + npc.global_position) / 2.0
	punto_medio.y -= 45
	
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(
		$Camera2D,
		"global_position",
		punto_medio,
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(
		$Camera2D,
		"zoom",
		Vector2(1.5, 1.5),
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
func restaurar_camara() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(
		$Camera2D,
		"global_position",
		global_position,
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(
		$Camera2D,
		"zoom",
		Vector2(1.0, 1.0),
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
