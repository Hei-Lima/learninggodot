extends CharacterBody2D

const SPEED = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Player1MoveUp"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("Player1MoveDown"):
		velocity.y = SPEED
	else:
		velocity.y = 0
	move_and_slide()
