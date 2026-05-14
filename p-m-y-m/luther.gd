extends CharacterBody2D
class_name personaje

@export var speed: float = 300.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	animation_player.play("idle")
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		set_movement_target(get_global_mouse_position())


func set_movement_target(target_point: Vector2):
	nav_agent.target_position = target_point
	

func cambio_direccion(direccion_x: float):
	if direccion_x < 0:
		sprite_2d.flip_h = true  # Va hacia la izquierda, voltear sprite
	elif direccion_x > 0:
		sprite_2d.flip_h = false # Va hacia la derecha, sprite normal

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()

	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * speed
	
	velocity = new_velocity
	cambio_direccion(velocity.x)

	move_and_slide()
