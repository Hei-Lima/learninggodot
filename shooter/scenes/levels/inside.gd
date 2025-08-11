extends LevelParent

#var outside_scene: PackedScene = preload("res://scenes/levels/outside.tscn")

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	print("Banana")
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	#get_tree().change_scene_to_packed(outside_scene)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
