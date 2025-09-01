extends CharacterBody2D

@export var speed: int = 300
@export var slide_factor: int = 900
@export var jump_speed: int = 400
@export var max_falling_speed: int = 400

var invulnerable: bool = false
var floor_position = Vector2.ZERO

var is_jumping: bool = false
var is_bouncing: bool = false
var moving_plataform_increment: int = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# --- Moviment horizontal ---
	var dir := int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

	if Input.is_action_pressed("duck") and is_on_floor():
		$PlayerSprite.play("duck")
		$PlayerSprite.flip_h = (dir < 0) if dir != 0 else $PlayerSprite.flip_h
		velocity.x = move_toward(velocity.x, dir * speed * 0.2, slide_factor * delta)
	elif dir != 0:
		$PlayerSprite.play("walking")
		$PlayerSprite.speed_scale = abs(velocity.x) / speed
		$PlayerSprite.flip_h = (dir < 0)
		velocity.x = move_toward(velocity.x, (dir * speed) + moving_plataform_increment, slide_factor * delta)
	else:
		$PlayerSprite.play("idle")
		velocity.x = move_toward(velocity.x, moving_plataform_increment, slide_factor * delta)
		print(get_floor_velocity())

	if Input.is_action_pressed("jump") and is_on_floor() and not Input.is_action_pressed("duck"):
		is_jumping = true
		velocity.y = -jump_speed
		$PlayerSprite.play("jump")

	if is_jumping and Input.is_action_just_released("jump") and velocity.y < 0:
		is_jumping = false
		velocity.y *= 0.5

	# --- Bounce logic ---
	if is_bouncing and Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
		is_bouncing = false

	# --- Gravity ---
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, -max_falling_speed, max_falling_speed)
		if not is_jumping and not is_bouncing:
			$PlayerSprite.play("jump")

	if is_on_floor():
		floor_position = get_floor_position() 
	
	if velocity.y == 0 or velocity.y > 0:
		set_collision_mask_value(6, true)
		is_jumping = false
		is_bouncing = false
	
	if velocity.y < 0 or Input.is_action_pressed("duck"):
		set_collision_mask_value(6, false)
		
	move_and_slide()
	Globals.player_pos = global_position

# --- Bounce method ---
func bounce(strength: int = 400) -> void:
	velocity.y = -strength
	is_bouncing = true
	$PlayerSprite.play("jump")

# --- Hit/invulnerable ---
func hit():
	if invulnerable:
		print("Not hit") 
		return

	print("Player Hit!")
	invulnerable = true
	$AnimationPlayer.play("hit")

func vulnerable() -> void:
	invulnerable = false

# --- Get floor position ---
func get_floor_position() -> Vector2:
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col and col.get_normal().dot(Vector2.UP) > 0.9:
			return col.get_position()
	return global_position
	
func get_floor_velocity() -> float:
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		var floor_velocity = col.get_collider().get("tile_velocity")
		if col and col.get_normal().dot(Vector2.UP) > 0.9 and floor_velocity:
			return floor_velocity
	return 0.0
