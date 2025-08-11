extends CanvasLayer

func update_scores():
	$MarginContainer/HBoxContainer/BluePoints.text = str(Globals.blue_points)
	$MarginContainer/HBoxContainer/RedPoints.text = str(Globals.red_points)
