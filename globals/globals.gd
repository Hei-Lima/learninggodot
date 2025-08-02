extends Node

signal health_change
signal laser_change
signal grenade_change
var player_pos: Vector2
var player_vulnerable: bool = true

var laser_ammount: int = 20:
	get:
		return laser_ammount
	set(value):
		laser_ammount = value
		laser_change.emit()		
		
var grenade_ammount: int = 5:
	get: 
		return grenade_ammount
	set(value): 
		grenade_ammount = value
		grenade_change.emit()
		
var health: int = 60:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		elif player_vulnerable:
			health = value
			player_vulnerable = false
			player_invulnerable_timer()
		health_change.emit()


func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
