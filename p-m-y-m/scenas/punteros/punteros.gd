extends Node2D

signal accion_disparada
enum EstadoPuntero { CAMINAR, HABLAR, USAR, LENGUA }
var estado_actual : EstadoPuntero = EstadoPuntero.CAMINAR
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var obj_debajo_mouse : Node = null
var bloqueado : bool = false
var animacion_forzada : String = ""

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_set_estado(estado_actual)
	print(anim)
	print("ready")

func _process(delta: float):
	global_position = get_global_mouse_position()
	if animacion_forzada != "":
		anim.play(animacion_forzada)

func _input(event):
	if event.is_action_pressed("click izq"):
		emit_signal("accion_disparada", estado_actual, get_global_mouse_position(), obj_debajo_mouse)

func _set_estado(nuevo_estado : EstadoPuntero):
	print("CAMBIO A:", nuevo_estado)
	estado_actual = nuevo_estado
	match estado_actual:
		EstadoPuntero.CAMINAR:
			anim.play("walk")
		EstadoPuntero.HABLAR:
			anim.play("talk")
		EstadoPuntero.USAR:
			anim.play("usar")
		EstadoPuntero.LENGUA:
			anim.play("lengua")
	anim.frame = 0

func _on_mouse_entered(objeto):
	if bloqueado:
		return
	print("ENTRO", objeto.name)
	obj_debajo_mouse = objeto
	if objeto.is_in_group("npc"):
		_set_estado(EstadoPuntero.HABLAR)
		print("soy hablar")
	else:
		_set_estado(EstadoPuntero.LENGUA)
		print("soy lengua")

func _on_mouse_exited():
	if bloqueado:
		return
	obj_debajo_mouse = null
	_set_estado(EstadoPuntero.CAMINAR)
	print("soy caminar")
