extends CharacterBody2D

var is_walking: bool = false
var is_attacking: bool = false
var can_attack: bool = false
var player_object
const SPEED = 200
var health = 50
var is_vulnerable: bool = true

func _on_notice_area_body_entered(body: Node2D) -> void:
	is_walking = true
	$AnimatedSprite2D.play("walking")

func _on_notice_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	is_walking = false
	$AnimatedSprite2D.play("idle")

func _on_attack_area_body_entered(body: Node2D) -> void:
	player_object = body
	print(player_object)
	is_attacking = true
	is_walking = false
	$AttackCooldown.start()
	$AnimatedSprite2D.play("attacking")

func _on_attack_area_body_exited(body: Node2D) -> void:
	is_attacking = false
	can_attack = false
	is_walking = true
	$AttackCooldown.stop()
	$AnimatedSprite2D.play("walking")

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func hit():
	if is_vulnerable:
		print("Hitted")
		health -= 10
		is_vulnerable = false
		$HitCooldown.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		if health <= 0:
			queue_free()

func _process(_delta: float) -> void:
	if is_walking:
		var direction: Vector2 = (Globals.player_pos - global_position).normalized()
		velocity = direction * SPEED
		rotation = direction.angle()
		move_and_slide()
	if is_attacking:
		if can_attack:
			player_object.hit()
			$AttackCooldown.start()
			can_attack = false

func _on_hit_cooldown_timeout() -> void:
	is_vulnerable = true
	$AnimatedSprite2Ds.material.set_shader_parameter("progress", 0)
	
