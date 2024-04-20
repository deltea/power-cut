class_name InputControl extends ProximityArea

signal activate(value: bool)

@export var power_line: PowerLine

@onready var sprite: Sprite = $Sprite

var enabled: bool:
	get: return enabled
	set(value):
		enabled = value
		on_set_enabled()

func on_set_enabled():
	if power_line:
		power_line.default_color = Color.RED if enabled else Color.WHITE
