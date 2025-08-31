extends CanvasLayer

func _ready():
	_update_coins(Globals.coins_collected)

	Globals.connect("coins_changed", Callable(self, "_update_coins"))

func _update_coins(value: int) -> void:
	$HudControl/VBoxContainer/Coins/CoinsCount.text = "Coins: " + str(value)
