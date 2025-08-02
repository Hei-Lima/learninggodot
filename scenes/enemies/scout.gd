extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_shooted: bool = false
var health: int = 30
var can_hit: bool = true
var hit_count = 1

signal laser(pos, dir)

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var pos: Vector2
			if right_shooted:
				pos = $LaserSpawnPositions/Marker2D.global_position
				right_shooted = false
				print("Shoot right")
			else:
				pos = $LaserSpawnPositions/Marker2D2.global_position
				right_shooted = true
				print("Shoot left")
			var dir: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, dir)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true
	
func hit():
	if can_hit:
		print("Hitted")
		health -= 10
		can_hit = false
		$HitCooldown.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		if health <= 0:
			queue_free()

func _on_hit_cooldown_timeout() -> void:
	can_hit = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
