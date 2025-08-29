extends Camera2D

var target_offset_x: float = 100
@onready var player = $"../Player"
var last_plataform
var platform_switch_threshold: float = 200

func _ready() -> void:
	position.y = player.position.y

func _physics_process(delta: float) -> void:
	if player.floor_position:
		if last_plataform:
			if player.floor_position.y > last_plataform.y:
				position.y = player.position.y
				last_plataform = player.floor_position
			
			elif player.floor_position.y < last_plataform.y - platform_switch_threshold:
				position.y = player.position.y
				last_plataform = player.floor_position
		else:
			last_plataform = player.floor_position


	global_position.x = player.global_position.x

	if player.velocity.x >= player.speed:
		target_offset_x = 100
	elif player.velocity.x <= -player.speed:
		target_offset_x = -100

	offset.x = lerp(offset.x, target_offset_x, delta)
