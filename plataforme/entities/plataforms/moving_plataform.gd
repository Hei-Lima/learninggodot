extends Path2D
enum StartMode {
	PLAYER_STANDING,
	AUTOSTART
}

@export var animatable_body:AnimatableBody2D
@export var speed: float = 100.0
@export var mode: StartMode = StartMode.PLAYER_STANDING

var direction := 1

func _ready():
	$PathFollow2D.rotates = false
	$PathFollow2D/RemoteTransform2D.remote_path = animatable_body.get_path()

func _process(delta: float) -> void:
	$PathFollow2D.progress += speed * delta * direction
	
	match mode:
		mode == StartMode.AUTOSTART:
			handle_autostart_mov()
	

func handle_autostart_mov():
	if $PathFollow2D.progress_ratio >= 1.0:
		direction = -1
	elif $PathFollow2D.progress_ratio <= 0.0:
		direction = 1
