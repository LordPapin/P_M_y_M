extends CharacterBody2D
class_name personaje

@export var speed: float = 300.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimatedSprite2D = $animacion

@onready var lengua = $Lengua
@onready var cuerpo_lengua = $Lengua/CuerpoLengua
@onready var punta_lengua = $Lengua/PuntaLengua

var longitud_lengua := 1.0
var recurso_objetivo = null
var lengua_activa := false
var lengua_extendiendo := false

@export var distancia_recoleccion := 150.0


func _ready() -> void:
	lengua.visible = false
	animation_player.play("idle")
	for recurso in get_tree().get_nodes_in_group("recursos"):
		recurso.clicked.connect(seleccionar_recurso)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_movement_target(get_global_mouse_position())


func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point


func _physics_process(_delta: float) -> void:
	if recurso_objetivo != null:
		print("DISTANCIA:",global_position.distance_to(recurso_objetivo.global_position))
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var current_agent_position = global_position
		var next_path_position = nav_agent.get_next_path_position()
		velocity = (
			next_path_position - current_agent_position
		).normalized() * speed
	move_and_slide()
	actualizar_animacion()
	if recurso_objetivo != null:
		if is_instance_valid(recurso_objetivo):
			var distancia = global_position.distance_to(recurso_objetivo.global_position)
			if distancia <= distancia_recoleccion:
				print("ESTOY CERCA: ", distancia)
				velocity = Vector2.ZERO
				iniciar_lengua()
				return

func _process(delta):

	if recurso_objetivo != null and is_instance_valid(recurso_objetivo):
		lengua.look_at(recurso_objetivo.global_position)
	else:
		lengua.look_at(get_global_mouse_position())

	if lengua_extendiendo:
		longitud_lengua += 25.0 * delta
		cuerpo_lengua.scale.x = longitud_lengua
		punta_lengua.position.x = 16 * longitud_lengua

	else:

		longitud_lengua = 1.0

		cuerpo_lengua.scale.x = 1.0

		punta_lengua.position.x = 16

		lengua.visible = false


func actualizar_animacion():

	if velocity.length() > 0:

		if abs(velocity.y) > abs(velocity.x):

			if velocity.y < 0:
				animation_player.play("walk_up")
			else:
				animation_player.play("walk")

		else:

			animation_player.play("walk")

			if velocity.x < 0:
				animation_player.flip_h = true

			elif velocity.x > 0:
				animation_player.flip_h = false

	else:

		animation_player.play("idle")

func seleccionar_recurso(recurso):
	print("CLICK EN: ", recurso.name)
	recurso_objetivo = recurso
	print("OBJETIVO:", recurso.global_position)
	nav_agent.target_position = recurso.global_position
	
func iniciar_lengua():
	if lengua_activa:
		return
	lengua_activa = true
	lengua_extendiendo = true
	longitud_lengua = 1.0
	lengua.visible = true
