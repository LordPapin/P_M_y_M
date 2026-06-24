extends CharacterBody2D
var miniJuego = ""
var conversable = false
@onready var MiSprite: AnimatedSprite2D #=


@onready var MiDialogo = preload ("res://dialogos/npc_cerrajero.dialogue")
func _ready() -> void:
	#MiSprite.play("idle")
	conversable = false
	pass


		

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

func _on_area_2d_mouse_entered() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_entered(self)

func _on_area_2d_mouse_exited() -> void:
	var cursor = get_tree().get_first_node_in_group("cursor")
	if cursor:
		cursor._on_mouse_exited()
