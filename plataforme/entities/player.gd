extends CharacterBody2D

@export var speed: int = 300
@export var slide_factor: int = 900
@export var jump_speed: int = 400
@export var max_falling_speed: int = 400

var floor_position = get_floor_position()

var is_jumping: bool = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Moviment direction
	var dir := int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

	# Movement
	if Input.is_action_pressed("duck") and is_on_floor():
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

	# Handle jump logic
	if Input.is_action_pressed("jump") and is_on_floor() and not Input.is_action_pressed("duck"):
		is_jumping = true
		velocity.y -= jump_speed
	
	if is_jumping and Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5  # corta metade da velocidade de subida
		is_jumping = false
		
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, -max_falling_speed, max_falling_speed)
		$PlayerSprite.play("jump")

	if is_on_floor():
		floor_position = get_floor_position()
		
	move_and_slide()

func get_floor_position():
	for i in get_slide_collision_count(): 
		var col = get_slide_collision(i)
		if col and col.get_normal().dot(Vector2.UP) > 0.9:
			return col.get_position()
