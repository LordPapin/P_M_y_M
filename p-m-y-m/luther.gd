extends CharacterBody2D
class_name personaje

@export var speed: float = 300.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimatedSprite2D = $animacion



func _ready() -> void:
	animation_player.play("idle")
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		set_movement_target(get_global_mouse_position())


func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point
	

func actualizar_animacion():
	# Si el personaje se está moviendo
	if velocity.length() > 0:
		
		# Comparamos si se mueve más en vertical (Y) que en horizontal (X)
		if abs(velocity.y) > abs(velocity.x):
			# Movimiento Vertical
			if velocity.y < 0:
				animation_player.play("walk_up")    # Va hacia arriba (Y negativo en Godot)
			else:
				animation_player.play("walk")  # Va hacia abajo (Y positivo en Godot)
		else:
			# Movimiento Horizontal
			animation_player.play("walk")
			
			# Volteamos el sprite según la dirección horizontal
			if velocity.x < 0:
				animation_player.flip_h = true  # Va hacia la izquierda
			elif velocity.x > 0:
				animation_player.flip_h = false # Va hacia la derecha
				
	else:
		# Si la velocidad es 0, reproducimos idle
		animation_player.play("idle")
func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		# Detenemos al personaje explícitamente cuando llega al destino
		velocity = Vector2.ZERO 
		actualizar_animacion() # Llamamos a la animación para que pase a idle
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	# Calculamos la nueva velocidad
	velocity = (next_path_position - current_agent_position).normalized() * speed
	
	# Movemos al personaje
	move_and_slide()
	
	# Actualizamos la animación en base a la velocidad que acabamos de aplicar
	actualizar_animacion()
