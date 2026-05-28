extends Node

signal inventory_updated

const MAX_SLOTS = 4
# Creamos un arreglo que solo acepta ItemData
var items: Array[ItemData] = []

func _ready():
	# Inicializamos los 4 espacios vacíos (null)
	items.resize(MAX_SLOTS)

func add_item(item: ItemData) -> bool:
	# Busca el primer espacio que esté vacío
	for i in range(MAX_SLOTS):
		if items[i] == null:
			items[i] = item
			inventory_updated.emit()
			return true # Se guardó con éxito
			
	print("El inventario está lleno (4/4)")
	return false # No había espacio
