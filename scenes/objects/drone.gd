extends CharacterBody2D



func _process(_delta) -> void:
	velocity.x = 300
	move_and_slide() 
