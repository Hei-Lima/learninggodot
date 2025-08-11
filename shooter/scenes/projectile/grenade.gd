extends RigidBody2D

const speed: int = 750
const damage_radius: int = 400
var exploding: bool = false

func explode() -> void:
	$AnimationPlayer.play("Explosion")
	exploding = true

func _process(_delta):
	var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
	if exploding:
		for target in targets:
			if global_position.distance_to(target.global_position) < 400:
				target.hit()
