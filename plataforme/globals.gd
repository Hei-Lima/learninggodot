extends Node

var player_pos
var coins_collected: int = 0
signal coins_changed(new_value)

func add_coin():
	coins_collected += 1
	emit_signal("coins_changed", coins_collected)