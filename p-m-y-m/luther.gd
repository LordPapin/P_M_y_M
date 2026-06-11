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


var longitud_lengua := 1.0
var recurso_objetivo = null
var objeto_atrapado = null

enum EstadoLengua { INACTIVA, EXTENDIENDO, RETRAYENDO }
var estado_lengua := EstadoLengua.INACTIVA
var recolectando := false

func _ready() -> void:
	lengua.visible = false
	animation_player.play("idle")
	for recurso in get_tree().get_nodes_in_group("recursos"):
		recurso.clicked.connect(seleccionar_recurso)

func _unhandled_input(event: InputEvent) -> void:
	if recolectando:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_movement_target(get_global_mouse_position())

func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point

func _physics_process(_delta: float) -> void:
	if recolectando:
		velocity = Vector2.ZERO
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
		print("dir: ", dir, " | angle: ", rad_to_deg(dir.angle()), " | lengua.rotation: ", rad_to_deg(lengua.rotation))
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
	if estado_lengua == EstadoLengua.EXTENDIENDO:
		print("punta: ", punta_lengua.global_position, " | objetivo: ", recurso_objetivo.global_position, " | distancia: ", punta_lengua.global_position.distance_to(recurso_objetivo.global_position))

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
	if velocity.length() > 0:
		if abs(velocity.y) > abs(velocity.x):
			animation_player.play("walk_up" if velocity.y < 0 else "walk")
		else:
			animation_player.play("walk")
			animation_player.flip_h = velocity.x < 0
	else:
		animation_player.play("idle")

func seleccionar_recurso(recurso) -> void:
	if recolectando:
		return
	recurso_objetivo = recurso
	nav_agent.target_position = recurso.global_position
