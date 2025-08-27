extends CharacterBody2D

@export var speed: int = 300
@export var slide_factor: int = 700
@export var jump_speed: int = 400
var is_ducking: bool = false
var can_jump: bool = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Movimento lateral
	var dir := int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

	# Duck tem prioridade
	if Input.is_action_pressed("duck") and is_on_floor():
		is_ducking = true
		$PlayerSprite.play("duck")
		$PlayerSprite.flip_h = (dir < 0) if dir != 0 else $PlayerSprite.flip_h
		# reduz velocidade para 20% da normal
		velocity.x = move_toward(velocity.x, dir * speed * 0.2, slide_factor * delta)
	elif dir != 0:
		$PlayerSprite.play("walking")
		$PlayerSprite.flip_h = (dir < 0)
		velocity.x = move_toward(velocity.x, dir * speed, slide_factor * delta)
	else:
		$PlayerSprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, slide_factor * delta)

	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Pulo (não pula se estiver duck)
	if Input.is_action_just_pressed("jump") and is_on_floor() and not Input.is_action_pressed("duck"):
		can_jump = false
		$JumpTimer.start()
		velocity.y -= jump_speed

	move_and_slide()




func _on_jump_timer_timeout() -> void:
	can_jump = true
