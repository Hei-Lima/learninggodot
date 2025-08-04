extends CharacterBody2D

var explosion_radius = 400
var active: bool = false
var vulnerable: bool = true
var max_speed = 600
var speed: int = 0
var speed_multiplier = 1

var health: int = 50

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta) -> void:
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")

func stop_movement():
	speed_multiplier = 0
	
func hit():
	if vulnerable:
		print("Drone")
		health -= 10
		vulnerable = false
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$HitTimer.start()
		if health <= 0:
			$AnimationPlayer.play("explosion")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
	
func hit_player():
	if Globals.player_pos.distance_to(global_position) < explosion_radius:
		Globals.health -= 10

	
	
