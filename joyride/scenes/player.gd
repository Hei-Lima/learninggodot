extends CharacterBody2D

@export var initial_speed = 100
@export var max_speed = 1000
@export var increment = 0.1

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if Globals.current_speed + increment <= max_speed:
		Globals.current_speed = snapped(Globals.current_speed + increment, 0.1)
	else:
		Globals.current_speed = max_speed
		
	position.x += Globals.current_speed * delta
		
