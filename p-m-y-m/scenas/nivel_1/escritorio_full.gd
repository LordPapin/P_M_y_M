extends Sprite2D

@onready var papel_1: TextureButton = $papel_1
@onready var papel_2: TextureButton = $papel_2

@onready var nota_1: Label = $Label
@onready var nota_2: Label = $Label2
@onready var salir_de_papel: TextureButton = $salir_de_papel

var luther = preload("res://scenas/jugador/luther.tscn")

func _on_papel_1_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if papel_1.disabled == false:
		if cursor:
			cursor._on_mouse_entered(self)


func _on_papel_1_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_papel_1_pressed() -> void:
	nota_1.visible = true
	salir_de_papel.visible = true
	papel_1.disabled = true
	papel_2.disabled = true
	var cursor = get_tree().get_first_node_in_group("cursor")
	cursor._on_mouse_exited()


func _on_papel_2_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if papel_2.disabled == false:
		if cursor:
			cursor._on_mouse_entered(self)


func _on_papel_2_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_papel_2_pressed() -> void:
	salir_de_papel.visible = true
	papel_1.disabled = true
	papel_2.disabled = true
	nota_2.visible = true
	var cursor = get_tree().get_first_node_in_group("cursor")
	cursor._on_mouse_exited()


func _on_salir_de_papel_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_salir_de_papel_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_salir_de_papel_pressed() -> void:
	papel_1.disabled = false
	papel_2.disabled = false
	salir_de_papel.visible = false
	nota_1.visible = false
	nota_2.visible = false


func _on_salir_btn_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)


func _on_salir_btn_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()


func _on_salir_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenas/nivel_1/nivel_1.tscn")
