extends CanvasLayer

# Referencia al contenedor de los espacios (ajusta la ruta si es un GridContainer)
@onready var contenedor_slots = $HBoxContainer

@onready var slots = [
	$HBoxContainer/TextureRect1,
	$HBoxContainer/TextureRect2,
	$HBoxContainer/TextureRect3,
	$HBoxContainer/TextureRect4,
	$HBoxContainer/TextureRect5
]

func _ready():
	Inventory.inventory_updated.connect(update_slots)
	
	# Conectamos cada espacio para que detecte el ratón y le pasamos su número (índice)
	for i in range(slots.size()):
		# .bind(i) envía el número del slot (0, 1, 2 o 3) a la función
		slots[i].gui_input.connect(_on_slot_gui_input.bind(i))
		
	update_slots()
	contenedor_slots.hide()
func update_slots():
	for i in range(Inventory.MAX_SLOTS):
		if Inventory.items[i] != null:
			slots[i].texture = Inventory.items[i].icon
		else:
			slots[i].texture = null


func _on_maletin_button_pressed():
	contenedor_slots.visible = !contenedor_slots.visible
	
func _on_slot_gui_input(event: InputEvent, index: int):
	# Detectamos si fue un clic izquierdo presionado
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# Solo hacemos algo si hay un objeto en ese espacio
		if Inventory.items[index] != null:
			print("Sacando objeto del espacio: ", index)
			
			# Aquí podrías añadir lógica si quieres soltar el objeto en el mundo de nuevo
			# ...
			
			# Borramos el objeto del inventario
			Inventory.remove_item(index)
