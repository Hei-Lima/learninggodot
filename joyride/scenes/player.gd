extends CharacterBody2D

@export var initial_speed = 100
@export var max_speed = 1000
@export var increment = 0.9
@export var jet_speed = 100

func _ready() -> void:
	$AnimationPlayer.play("Running")

func _physics_process(delta: float) -> void:
	if Globals.current_speed + increment <= max_speed:
		Globals.current_speed = snapped(Globals.current_speed + increment, 0.1)
	else:
		Globals.current_speed = max_speed	
	position.x += Globals.current_speed * delta
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimationPlayer.play("Falling")
	else:
		$AnimationPlayer.play("Running")
	
	if Input.is_action_pressed("Up"):
		velocity.y -= jet_speed
		$AnimationPlayer.play("Flying")
	else:
		velocity.y = move_toward(velocity.y, 0, jet_speed)
		
	$AnimationPlayer.speed_scale = (Globals.current_speed + 200) / 50
		
	move_and_slide()
