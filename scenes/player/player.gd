extends CharacterBody2D


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta) -> void:
	# Input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	# Laser shoot:
	if Input.is_action_pressed("primary action"):
		print("laser")
		
	if Input.is_action_pressed("secondary action"):
		print("grenade")
