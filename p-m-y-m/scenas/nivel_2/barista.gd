extends AnimatedSprite2D
@onready var barista: AnimatedSprite2D = $"."


func free() -> void:
	barista.play("idle")
