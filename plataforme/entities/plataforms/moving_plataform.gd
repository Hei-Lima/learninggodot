extends Path2D
enum StartMode {
	PLAYER_STANDING,
	AUTOSTART
}

var player_entered_area: bool = false
@export var animatable_body:AnimatableBody2D
@export var speed: float = 100.0
@export var mode: StartMode = StartMode.AUTOSTART

var direction := 1

func _ready():
	$PathFollow2D.rotates = false
	$PathFollow2D/RemoteTransform2D.remote_path = animatable_body.get_path()

func _process(delta: float) -> void:	
	if mode == StartMode.AUTOSTART:
		handle_autostart_mov(delta)
	elif mode == StartMode.PLAYER_STANDING:
		handle_player_standing(delta)
	

func handle_autostart_mov(delta):
	$PathFollow2D.progress += speed * delta * direction
	
	if $PathFollow2D.progress_ratio >= 1.0:
		direction = -1
	elif $PathFollow2D.progress_ratio <= 0.0:
		direction = 1

func handle_player_standing(delta):
	if player_entered_area:
		$PathFollow2D.progress += speed * delta * direction
	if $PathFollow2D.progress_ratio >= 1.0:
		speed = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	player_entered_area = true
