extends Path2D
@export var follow:PathFollow2D
@export var follow_tiles:TileMapLayer
var tile_velocity

@export var speed: float = 100.0
var direction := 1

func _on_ready():
	follow.rotates = false

func _process(delta: float) -> void:
	follow.progress += speed * delta * direction
	
	if follow.progress_ratio >= 1.0:
		direction = -1
	elif follow.progress_ratio <= 0.0:
		direction = 1
		
	follow_tiles.tile_velocity = speed * direction
