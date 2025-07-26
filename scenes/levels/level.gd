extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectile/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectile/grenade.tscn")

func _on_gate_player_entered_gate() -> void:
	print("Entered")

func _on_player_laser(pos, dir) -> void:
	var laser = laser_scene.instantiate() as Area2D
	$Projectiles.add_child(laser)
	laser.direction = dir
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.position = pos

func _on_player_grenade(pos, dir) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	$Projectiles.add_child(grenade)
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
