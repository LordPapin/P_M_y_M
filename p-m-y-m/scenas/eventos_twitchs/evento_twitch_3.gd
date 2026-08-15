extends CanvasLayer

# ============================================================
# ESCENAS
# ============================================================

@export var pez_escena: PackedScene
@export var piraña_escena: PackedScene


# ============================================================
# REFERENCIAS A NODOS
# ============================================================

# ¡ASEGURATE de que este sea el nombre exacto de tu Label en la escena!
@onready var label_puntos = $Label

@onready var contenedor_peces = $Node2D/fishSpawner
@onready var contenedor_pirania = $Node2D/piraniaSpawner

@onready var timer_spawn = $Node2D/fishSpawner/fishTimer
@onready var timer_piranias = $Node2D/piraniaSpawner/piraniaTimer

@onready var pantalla_derrota = $pantalla_reintentar
@onready var reintentar_btn = $pantalla_reintentar/reintentar_btn

@onready var pantalla_ganado = $pantalla_ganado


# ============================================================
# SEÑALES
# ============================================================

signal Derrota
signal Ganado


# ============================================================
# PUNTUACIÓN
# ============================================================

var puntuacion: int = 0


# ============================================================
# VELOCIDAD DE LOS PECES
# ============================================================

@export var velocidad_pez_inicial: float = 100.0
@export var velocidad_pez_nivel_2: float = 150.0
@export var velocidad_pez_nivel_3: float = 200.0

var velocidad_actual_peces: float = 100.0


# ============================================================
# INICIO
# ============================================================

func _ready():

	# Conectar los timers por código de forma segura
	if not timer_spawn.timeout.is_connected(_on_spawn_timer_timeout):
		timer_spawn.timeout.connect(_on_spawn_timer_timeout)
		
	if not timer_piranias.timeout.is_connected(_on_spawn_timer_piranias):
		timer_piranias.timeout.connect(_on_spawn_timer_piranias)

	# Velocidad inicial
	velocidad_actual_peces = velocidad_pez_inicial

	# Iniciar aparición de peces y pirañas
	timer_spawn.start(1.5)
	timer_piranias.start(3.0)

	# Forzar la actualización del texto al empezar
	actualizar_peces_lb()

	# Ocultar pantallas
	pantalla_derrota.hide()
	pantalla_ganado.hide()


# ============================================================
# APARECER PIRAÑA
# ============================================================

func _on_spawn_timer_piranias():

	var nueva_pirania = piraña_escena.instantiate()
	var x_aleatorio = randf_range(100.0, 700.0)
	nueva_pirania.position = Vector2(x_aleatorio, 600)

	# Cuando atrapemos una piraña → derrota
	nueva_pirania.atrapado.connect(_piraña_atrapada)
	contenedor_pirania.add_child(nueva_pirania)


# ============================================================
# APARECER PEZ
# ============================================================

func _on_spawn_timer_timeout():

	var nuevo_pez = pez_escena.instantiate()
	var x_aleatorio = randf_range(100.0, 700.0)
	nuevo_pez.position = Vector2(x_aleatorio, 600)

	# Le damos al pez la velocidad actual
	nuevo_pez.velocidad = velocidad_actual_peces

	# Cuando atrapemos un pez → sumar punto
	nuevo_pez.atrapado.connect(sumar_punto)
	contenedor_peces.add_child(nuevo_pez)


# ============================================================
# ATRAPAR PEZ (Aquí se actualiza en tiempo real)
# ============================================================

func sumar_punto():

	puntuacion += 1
	print("Puntuación: ", puntuacion)

	# LLAMADA CLAVE: Actualiza el texto inmediatamente al capturar un pez
	actualizar_peces_lb()

	# Nivel 2
	if puntuacion == 4:
		velocidad_actual_peces = velocidad_pez_nivel_2
		print("¡Velocidad aumentada! Nivel 2")

	# Nivel 3
	elif puntuacion == 7:
		velocidad_actual_peces = velocidad_pez_nivel_3
		print("¡Velocidad aumentada! Nivel 3")

	# Victoria
	if puntuacion >= 10:
		emit_signal("Ganado")


# ============================================================
# ATRAPAR PIRAÑA
# ============================================================

func _piraña_atrapada():

	print("¡Pescaste una piraña! DERROTA")
	emit_signal("Derrota")


# ============================================================
# ACTUALIZAR TEXTO (Método que modifica el Label)
# ============================================================

func actualizar_peces_lb():
	if label_puntos:
		label_puntos.text = " Peces atrapados: " + str(puntuacion) + "/10 "
	else:
		print("Error: No se encontró el nodo Label.")


# ============================================================
# DETECTAR LO QUE ATRAPÓ LA LENGUA
# ============================================================

func _on_area_punta_lengua_area_entered(area: Area2D) -> void:

	if area.is_in_group("peces"):
		area.ser_atrapado()
	elif area.is_in_group("piranias"):
		area.ser_atrapado()


# ============================================================
# DERROTA
# ============================================================

func _on_derrota() -> void:

	pantalla_derrota.show()
	get_tree().paused = true


# ============================================================
# VICTORIA
# ============================================================

func _on_ganado() -> void:

	print("¡GANASTE!")
	pantalla_ganado.show()
	get_tree().paused = true


# ============================================================
# REINTENTAR
# ============================================================

func _on_reintentar_btn_pressed() -> void:

	get_tree().paused = false
	get_tree().reload_current_scene()
