extends Node

signal inventory_updated

const MAX_SLOTS = 5
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
			
	print("El inventario está lleno (5/5)")
	return false # No había espacio

func remove_item(index: int):
	# Verificamos que el índice sea válido y que haya un objeto ahí
	if index >= 0 and index < MAX_SLOTS and items[index] != null:
		items[index] = null # Vaciamos el espacio
		inventory_updated.emit() # Avisamos a la interfaz para que se actualice
		
# Busca el objeto por su ID, lo borra y devuelve 'true' si lo logró
func consume_item(item_id: String) -> bool:
	print("=== INTENTANDO CONSUMIR ===")
	print("El NPC busca el ID exacto: '", item_id, "'")
	
	for i in range(MAX_SLOTS):
		if items[i] != null:
			print("En el slot ", i, " el inventario tiene: '", items[i].id, "'")
			
			if items[i].id == item_id:
				items[i] = null 
				inventory_updated.emit() 
				print("¡ÉXITO! ID coincidente. Imagen borrada.")
				return true 
		else:
			print("Slot ", i, " está vacío.")
			
	print("FRACASO: El inventario recorrió los 4 slots y no encontró coincidencia.")
	return false
# 1. Función para saber si el jugador tiene el ítem
func tiene_item(item_id: String) -> bool:
	for i in range(MAX_SLOTS):
		# Verificamos que el slot no esté vacío Y que el ID coincida
		if items[i] != null and items[i].id == item_id:
			return true
	
	return false # Si revisa todo y no lo encuentra, devuelve falso

# 2. Tu función consume_item adaptada para llamarse eliminar_item
func eliminar_item(item_id: String) -> bool:
	print("=== INTENTANDO CONSUMIR ===")
	print("El NPC busca el ID exacto: '", item_id, "'")
	
	for i in range(MAX_SLOTS):
		if items[i] != null:
			print("En el slot ", i, " el inventario tiene: '", items[i].id, "'")
			
			if items[i].id == item_id:
				items[i] = null 
				inventory_updated.emit() 
				print("¡ÉXITO! ID coincidente. Ítem borrado.")
				return true 
		else:
			print("Slot ", i, " está vacío.")
			
	print("FRACASO: El inventario recorrió los 5 slots y no encontró coincidencia.")
	return false
