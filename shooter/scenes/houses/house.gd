extends Area2D

signal player_enetered
signal player_exited


func _on_body_entered(_body: Node2D) -> void:
	player_enetered.emit()

func _on_body_shape_exited(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	player_exited.emit()
