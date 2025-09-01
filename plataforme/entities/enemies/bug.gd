extends Enemy

enum direction {Left, Right} 
@export var starting_dir = direction.Left

func _ready() -> void:
	dir = -1 if starting_dir == direction.Left else 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED * dir

	var col = get_collision()
	
	if col:
		if col != last_collsion_side:
			dir = -dir
			last_collsion_side = col

	move_and_slide()
