extends CharacterBody2D

signal laser(position, direction)
signal grenade(position, direction)

var hit_count = 1
var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta) -> void:
	# Input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# Rotate
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	# Laser shoot:
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_ammount > 0:
		Globals.laser_ammount -= 1
		var laser_markers = $LaserStartPosition.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_marker.global_position, player_direction)
		$GPUParticles2D.position = selected_marker.position
		$GPUParticles2D.restart()
		can_laser = false
		$TimerLaser.start()
	# Grenade
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_ammount > 0:
		Globals.grenade_ammount -= 1
		can_grenade = false
		$TimerGrenade.start()
		var grenade_position = $LaserStartPosition.get_children()[0]
		grenade.emit(grenade_position.global_position, player_direction)

func _on_timer_laser_timeout() -> void:
	can_laser = true

func _on_timer_grenade_timeout() -> void:
	can_grenade = true
	
func hit():
	Globals.health -= 10

	
	
