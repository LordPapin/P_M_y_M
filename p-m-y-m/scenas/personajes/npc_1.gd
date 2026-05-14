extends CharacterBody2D
var miniJuego = "res://scenas/eventos_twitchs/evento_twitch_1.tscn"
var conversable = false
@onready var MiDialogo = preload ("res://dialogos/diálogo npc1.dialogue")
@export var personaje = PackedScene
func _ready() -> void:
	conversable = false
	pass

func _handle_interaction():
	var state = NPCstates.npcs ["npc1"]["current_state"]
	match state:
		"no_interactuado":
			print("diálogo inicial")
			get_tree().change_scene_to_file("res://scenas/eventos_twitchs/evento_twitch_1.tscn")

			NPCstates.npcs["npc1"]["current_state"] = "no_sobornado"
		"no_sobornado":
			print("pide el soborno")
		"robado":
			print("es robado")
		"sobornado":
			print("información muy importante")

		

func _on_cercanía_de_conv_body_entered(body: Node2D) -> void:
	if body is personaje:
		conversable = true
		print(conversable)


func _on_cercanía_de_conv_body_exited(body: Node2D) -> void:
	if body is personaje:
		conversable = false
		print(conversable)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.pressed && conversable == true:
		DialogueManager.show_dialogue_balloon(MiDialogo, "start")
		await DialogueManager.dialogue_ended
		_handle_interaction()
