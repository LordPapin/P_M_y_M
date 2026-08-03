extends Node2D


var jump_height := 80.0
var jump_duration := 0.5
#var wait_time := 0.7
var is_jumping = false
var jump_points := []
var current_point := 1


func jump_to(target_index):
	is_jumping = true
	var start_pos = global_position
	var end_pos = jump_points[target_index].global_position
	current_point = target_index
	var time := 0.0
	while time < jump_duration:
		await get_tree().process_frame
		time += get_process_delta_time()
		var t = time / jump_duration
		var pos = start_pos.lerp(end_pos, t)
		pos.y -= sin(t * PI) * jump_height
		global_position = pos
	global_position = end_pos
	is_jumping = false
