extends StaticBody2D

@onready var anim = $animacion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("default")
