extends CanvasLayer

# Colors
var green: Color = Color("#6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $AmmoCounter/Laser/LaserLabel
@onready var laser_texture: TextureRect = $AmmoCounter/Laser/TextureRect
@onready var grenade_label: Label = $GrenadeCounter/Grenade/GrenadeLabel
@onready var grenade_texture: TextureRect = $GrenadeCounter/Grenade/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	update_laser_text()
	update_grenade_text()
	update_health()
	Globals.connect("health_change", update_health)
	Globals.connect("grenade_change", update_grenade_text)
	Globals.connect("laser_change", update_laser_text)
	

func update_laser_text():
	laser_label.text = str(Globals.laser_ammount)
	update_color(Globals.laser_ammount, laser_label, laser_texture)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_ammount)
	update_color(Globals.grenade_ammount, grenade_label, grenade_texture)

func update_color(ammount: int, label: Label, icon: TextureRect) -> void:
	if ammount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
		
func update_health():
	health_bar.value = Globals.health
