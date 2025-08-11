extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, parent_direction)
		opened = true
	
