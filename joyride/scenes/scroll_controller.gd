extends Node2D

const speed = 1000

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	var axis = Input.get_axis("left", "right")
	position.x += axis * speed * delta
	print(axis)
	print($Camera2D.global_position)
