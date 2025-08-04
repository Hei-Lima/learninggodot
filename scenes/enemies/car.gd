extends PathFollow2D

@onready var line1 = $Turret/RayCast2D/Line2D
@onready var line2 = $Turret/RayCast2D2/Line2D

var player_near: bool = false

func fire():
	Globals.health -= 20

func _ready():
	line1.width = 0
	line2.width = 0
	line2.add_point($Turret/RayCast2D2.target_position)

func _process(delta: float) -> void:
	progress_ratio += 0.01 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
	await tween.finished 
	$AnimationPlayer.stop()
