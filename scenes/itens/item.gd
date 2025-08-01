extends Area2D

var rotation_speed = 4
var avaliable_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = avaliable_options[randi()%len(avaliable_options)]

func _ready() -> void:
	if type == "laser":
		$Sprite2D.modulate = Color(0.1, 0.2, 0.8)
	if type == "grenade":
		$Sprite2D.modulate = Color(0.8, 0.1, 0.2) 
	if type == "health":
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1) 

func _process(delta: float) -> void:
	rotation += rotation_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if type == "laser":
		Globals.laser_ammount += 10
	if type == "grenade":
		Globals.grenade_ammount += 5
	if type == "health":
		Globals.health += 10
	queue_free()
