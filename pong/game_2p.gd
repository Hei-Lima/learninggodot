extends Node2D
var ball = preload("res://ball_2.tscn")
@export var speed: int = 500

func reset_ball(side):
	var new_ball = ball.instantiate()
	add_child(new_ball)
	new_ball.position =  get_viewport_rect().size / 2.0
	$Timer.start()
	await $Timer.timeout
	print(new_ball.position)
	var angle = deg_to_rad(randf_range(-45, 45))
	if side == "LEFT":
		new_ball.apply_impulse(Vector2.LEFT.rotated(angle) * speed)
	else:
		new_ball.apply_impulse(Vector2.RIGHT.rotated(angle) * speed)
	
func _ready() -> void:
	# Center the paddles vertically
	$Paddle.position.y =  get_viewport_rect().size.y / 2.0
	$Paddle2.position.y =  get_viewport_rect().size.y / 2.0

	reset_ball("LEFT")
	var new_ball = ball.instantiate()
	get_tree().root.add_child(new_ball)
	new_ball.position =  get_viewport_rect().size / 2.0

func _on_red_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	Globals.blue_points += 1
	$Control.update_scores()
	reset_ball("RIGHT")

func _on_blue_area_body_entered(body: Node2D) -> void:
	body.queue_free()
	Globals.red_points += 1
	$Control.update_scores()
	reset_ball("LEFT")
