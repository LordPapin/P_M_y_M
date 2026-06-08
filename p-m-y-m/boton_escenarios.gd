extends CanvasLayer

@onready var boton = $MarginContainer/Button
@onready var menu = $MarginContainer/menu

#acá debería ir la ruta a la escena inicial del juego
var escena_actual = ""

func _ready():
	menu.visible = false
	escena_actual = get_tree().current_scene.scene_file_path

func _on_button_pressed() -> void:
	menu.visible = true

func cambiar_escena(ruta_escena):
	if ruta_escena == escena_actual:
		menu.visible = false
		return
	get_tree().change_scene_to_file(ruta_escena)

#acá debería ir la ruta a una escena del juego
func _on_escenario_1_pressed() -> void:
	#cambiar_escena("")
	print("cambiaste a escenario 1")
	get_tree().change_scene_to_file("res://scenas/nivel_1/nivel_1.tscn")

#acá debería ir la ruta a una escena del juego
func _on_escenario_2_pressed() -> void:
	#cambiar_escena("")
	print("cambiaste a escenario 2")
	get_tree().change_scene_to_file("res://scenas/nivel_2/nivel_2.tscn")

#acá debería ir la ruta a una escena del juego
func _on_escenario_3_pressed() -> void:
	#cambiar_escena("")
	print("cambiaste a escenario 3")

func _on_salir_pressed() -> void:
	menu.visible = false
