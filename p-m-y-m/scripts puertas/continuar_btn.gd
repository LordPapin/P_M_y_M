extends TextureButton


func _on_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)
		
func _on_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
