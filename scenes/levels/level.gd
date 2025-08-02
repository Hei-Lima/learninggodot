extends Node2D
class_name LevelParent
	
var laser_scene: PackedScene = preload("res://scenes/projectile/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectile/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/itens/item.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)

func create_laser(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	$Projectiles.add_child(laser)
	laser.direction = dir
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.position = pos
	$UI.update_laser_text()

func _on_scout_laser(pos, dir):
	create_laser(pos, dir)


func _on_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	$Items.call_deferred('add_child', item)

func _on_player_laser(pos, dir) -> void:
	create_laser(pos, dir)

func _on_player_grenade(pos, dir) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	$Projectiles.add_child(grenade)
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$UI.update_grenade_text()
