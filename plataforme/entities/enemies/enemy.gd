extends CharacterBody2D
class_name Enemy

var SPEED = 50
var dir = 1
var last_collsion_side

func get_collision():
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col:
			var normal = col.get_normal()
			if normal.dot(Vector2.LEFT) > 0.9:
				return "left"
			elif normal.dot(Vector2.RIGHT) > 0.9:
				return "right"
	return null

func get_collision_up():
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col:
			var normal = col.get_normal()
			if normal.dot(Vector2.UP) > 0.9:
				return "up"
			elif normal.dot(Vector2.DOWN) > 0.9:
				return "down"
	return null


func _on_hurtbox_body_entered(body: Node2D) -> void:
	_process_collision(body, true)


func _on_hitbox_body_entered(body: Node2D) -> void:
	_process_collision(body, false)


func _process_collision(body: Node2D, is_hurtbox: bool) -> void:
	if is_hurtbox and body.has_method("bounce") and body.velocity.y > 0:
		body.bounce()
		print("Death")
		queue_free()
		return
	
	if not is_hurtbox and is_inside_tree():
		if body.has_method("hit"):
			body.hit()
