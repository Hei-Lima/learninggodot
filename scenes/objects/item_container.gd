extends StaticBody2D

class_name ItemContainer

signal open(pos, dir)

func _dummy_emit():
	emit_signal("open", Vector2.ZERO, Vector2.ZERO)

var opened: bool = false

@onready var parent_direction: Vector2 = Vector2.DOWN.rotated(rotation)
