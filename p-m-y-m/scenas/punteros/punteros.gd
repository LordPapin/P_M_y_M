extends Node2D

signal accion_disparada

enum EstadoPuntero { CAMINAR, MIRAR, HABLAR, USAR, LENGUA}
var estado_actual : EstadoPuntero = EstadoPuntero.CAMINAR

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var obj_debajo_mouse : Node = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_set_estado(estado_actual)


func _process(delta: float):
	global_position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("click izq"):
		emit_signal("accion_disparada", estado_actual,get_global_mouse_position(),obj_debajo_mouse)
	
	if event.is_action_pressed("click der"):
		_cambiar_estado()


func _set_estado(nuevo_estado : EstadoPuntero):
	estado_actual = nuevo_estado
	match estado_actual:
		EstadoPuntero.CAMINAR: anim.play("walk")
		EstadoPuntero.MIRAR: anim.play("mirar")
		EstadoPuntero.HABLAR: anim.play("talk")
		EstadoPuntero.USAR: anim.play("usar")
		EstadoPuntero.LENGUA: anim.play("lengua")
	anim.frame = 0


func _cambiar_estado():
	var nuevo_estado = (estado_actual + 1) % EstadoPuntero.size()
	_set_estado(nuevo_estado)

func _on_mouse_entered(objeto):
	obj_debajo_mouse = objeto
	anim.frame = 1


func _on_mouse_exited():
	obj_debajo_mouse = null
	anim.frame = 0
