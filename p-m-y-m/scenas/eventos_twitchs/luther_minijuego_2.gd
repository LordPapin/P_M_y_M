extends CharacterBody2D

signal grafiti_alcanzado(indice)
@onready var animacion: AnimatedSprite2D = $animacion


@export var velocidad := 100.0

var estado_actual := "no_advertido"

var destino : Marker2D = null
var indice_destino := -1

func _ready() -> void:
	var frames = animacion.sprite_frames
	animacion.play("idle")
	frames.set_animation_loop("idle", false)
	frames.set_animation_loop("caminar", true)


func _physics_process(delta):

	if destino == null:
		return

	var direccion = global_position.direction_to(destino.global_position)

	velocity = direccion * velocidad
	caminar()
	move_and_slide()

	if global_position.distance_to(destino.global_position) < 5:
		global_position = destino.global_position
		velocity = Vector2.ZERO
		animacion.play("idle")
		var indice = indice_destino
		destino = null
		indice_destino = -1
		
		grafiti_alcanzado.emit(indice)


func ir_a_grafiti(marker:Marker2D, indice:int):
	destino = marker
	indice_destino = indice
	


func cambiar_estado(nuevo_estado:String):

	estado_actual = nuevo_estado

	print("Estado Luther:", estado_actual)


func caminar():
	if velocity != Vector2.ZERO:
		if animacion.animation != "caminar":
			animacion.play("caminar")
	
	else:
		# Si la velocidad es cero, estamos quietos
		animacion.play("idle")
