extends Node2D

#referencias de los nodos hijos de Luther en el Minijuego 3
@onready var boca = $boca
@onready var lengua = $lengua
@onready var punta = $punta_lengua
@onready var luther_sprite = $lutherSprite
############################################################

var animado :bool = false

func _input(event):
	if event.is_action_pressed("dispararLengua") and not animado:
		disparar_lengua(get_global_mouse_position())

func _process(delta):
	lengua.clear_points()
	lengua.add_point(lengua.to_local(boca.global_position))
	lengua.add_point(lengua.to_local(punta.global_position))


func disparar_lengua(target_pos):
	animado = true
	lengua.visible = true
	punta.visible = true
	punta.global_position = boca.global_position
	
	
	var tween = create_tween()
	
	tween.tween_property(punta,"global_position",target_pos,0.2).set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(punta, "global_position", boca.global_position, 0.2)\
	.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	tween.tween_callback(anim_lengua_finalizada) 
	#aca es cuando termina la animacion llama a la otra funcion
 

func anim_lengua_finalizada():
	animado = false
	lengua.visible = false
	punta.visible = false
