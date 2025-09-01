extends Enemy

enum direction {Up, Down} 
@export var starting_dir = direction.Up

func _ready() -> void:
	dir = -1 if starting_dir == direction.Up else 1

func _physics_process(delta: float) -> void:
	velocity.y = SPEED * dir

	var col = get_collision_up()
	
	if col:
		if col != last_collsion_side:
			dir = -dir
			last_collsion_side = col

	move_and_slide()
