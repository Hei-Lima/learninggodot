extends AnimatableBody2D

@export var path_follow: PathFollow2D
@export var speed: float = 100.0

var last_pos: Vector2

func _ready():
	path_follow =  $".."
	last_pos = path_follow.global_position

func _physics_process(delta: float) -> void:
	path_follow.progress += speed * delta
	var target_pos = path_follow.global_position
	var motion = target_pos - last_pos
	move_and_collide(motion)
	last_pos = global_position
