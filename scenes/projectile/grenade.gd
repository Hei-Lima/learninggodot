extends RigidBody2D

const speed: int = 750

func explode() -> void:
	$AnimationPlayer.play("Explosion")
