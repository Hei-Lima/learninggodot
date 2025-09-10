extends CanvasLayer

func _ready():
	_update_coins(Globals.coins_collected)
	_update_lives(Globals.player_lives)

	Globals.connect("coins_changed", Callable(self, "_update_coins"))
	Globals.connect("lives_changed", Callable(self, "_update_lives")) # precisa emitir esse sinal no Globals

func _update_coins(value: int) -> void:
	$HudControl/VBoxContainer/Coins/CoinsCount.text = "Coins: " + str(value)

func _update_lives(value: int) -> void:
	$HudControl/VBoxContainer/Health/LivesCount.text = "Lives: " + str(value)
