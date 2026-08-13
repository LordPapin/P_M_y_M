extends Sprite2D

@onready var papel_1: TextureButton = $papel_1
@onready var papel_2: TextureButton = $papel_2

@onready var nota_1: Label = $Label
@onready var nota_2: Label = $Label2
@onready var salir_de_papel: TextureButton = $salir_de_papel

# En el script de "escritorio"
var mi_oficina = preload("res://scenas/nivel_1/nivel_1.tscn")

func cambiar_a_oficina():
	# 1. Instanciar en memoria
	var instancia_oficina = mi_oficina.instantiate() # En Godot 3 usa .instance()
	
	# 2. Modificar tu variable
	instancia_oficina.luther_escritorio = true
	
	# 3. Cambiar la escena de la pantalla por la nueva instancia
	get_tree().root.add_child(instancia_oficina) # Añade la nueva escena al root
	get_tree().current_scene = instancia_oficina # La vuelve la escena activa
	queue_free() # Elimina por completo la escena del "escritorio"


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
	cambiar_a_oficina()
