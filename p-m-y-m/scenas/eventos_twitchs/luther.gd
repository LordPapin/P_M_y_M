extends Node2D

@onready var boca = $boca
@onready var lengua = $lengua
var score := 0

func _input(event):
	if event.is_action_pressed("dispararLengua"):
		disparar_lengua(get_global_mouse_position())

func disparar_lengua(target_pos):
	lengua.visible = true
	lengua.clear_points()
	lengua.add_point(lengua.to_local(boca.global_position))
	lengua.add_point(lengua.to_local(target_pos))
	await get_tree().create_timer(0.08).timeout
	lengua.visible = false
