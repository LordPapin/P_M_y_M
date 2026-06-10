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
