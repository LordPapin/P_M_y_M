extends CharacterBody2D

@export var jump_height := 80.0
@export var jump_duration := 0.5
@export var wait_time := 0.7
var jump_points := []
var current_point := 0
var is_jumping := false

func _ready():
	jump_points = $"../jump_points".get_children()
	current_point = 1
	global_position = jump_points[current_point].global_position
	jump_loop()

func jump_loop():
	while true:
		await get_tree().create_timer(wait_time).timeout
		var next_point = choose_next_point()
		await jump_to(next_point)
		
func choose_next_point():
	var possible = []
	if current_point > 0:
		possible.append(current_point - 1)
	if current_point < jump_points.size() - 1:
		possible.append(current_point + 1)
	return possible.pick_random()
	
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
