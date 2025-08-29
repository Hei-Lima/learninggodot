extends Camera2D

var target_offset_x: float = 100
@onready var player = $"../Player"
var last_plataform

func _ready() -> void:
	position.y = player.position.y

func _physics_process(delta: float) -> void:
	if (player.floor_position != last_plataform) or player.velocity.y >= 400:
		position.y = player.position.y
		player.floor_position = last_plataform
	
	global_position.x = player.global_position.x

	if player.velocity.x >= player.speed:
		target_offset_x = 100
	elif player.velocity.x <= -player.speed:
		target_offset_x = -100

	offset.x = lerp(offset.x, target_offset_x, delta)
