extends CanvasLayer

@export var pez_escena: PackedScene
@export var piraña_escena : PackedScene
@onready var label_puntos = $Label
@onready var contenedor_peces = $Node2D/fishSpawner 
@onready var contenedor_pirania = $Node2D/piraniaSpawner
@onready var timer_spawn = $Node2D/fishSpawner/fishTimer
@onready var timer_piranias = $Node2D/piraniaSpawner/piraniaTimer
@onready var pantalla_derrota = $pantalla_reintentar
@onready var reintentar_btn = $pantalla_reintentar/reintentar_btn

signal Derrota
signal Ganado

var puntuacion: int = 0

func _ready():
	timer_spawn.timeout.connect(_on_spawn_timer_timeout)
	timer_piranias.timeout.connect(_on_spawn_timer_piranias)
	timer_spawn.start(1.5) # Aparece un pez
	timer_piranias.start(3.0)
	actualizar_peces_lb()
	pantalla_derrota.hide()


func _on_spawn_timer_piranias():
	var nueva_pirania = piraña_escena.instantiate()
	var x_aleatorio = randf_range(100.0, 700.0)
	nueva_pirania.position = Vector2(x_aleatorio, 600)
	nueva_pirania.atrapado.connect(restar_punto)
	contenedor_pirania.add_child(nueva_pirania)


func _on_spawn_timer_timeout():
	var nuevo_pez = pez_escena.instantiate()
	var x_aleatorio = randf_range(100.0, 700.0)
	nuevo_pez.position = Vector2(x_aleatorio, 600)
	nuevo_pez.atrapado.connect(sumar_punto)
	contenedor_peces.add_child(nuevo_pez)

func sumar_punto():
	puntuacion += 1
	actualizar_peces_lb()


func restar_punto():
	if puntuacion >= 1:
		puntuacion -= 1
	else :
		emit_signal("Derrota")
	actualizar_peces_lb()


func actualizar_peces_lb():
	label_puntos.text = "Peces atrapados: " + str(puntuacion)


func _on_area_punta_lengua_area_entered(area: Area2D) -> void:
	if area.is_in_group("peces"):
		area.ser_atrapado() 
	elif area.is_in_group("piranias"):
		area.ser_atrapado()


func _on_derrota() -> void:
	pantalla_derrota.show()
	get_tree().paused = true


func _on_reintentar_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_ganado() -> void:
	if puntuacion >= 10:
		queue_free()
