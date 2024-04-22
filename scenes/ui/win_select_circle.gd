class_name WinSelectCircle extends LevelSelectCircle

@onready var win_icon: Sprite2D = $Sprite/WinIcon

func update() -> void:
	locked_indicator.visible = locked
	win_icon.visible = not locked_indicator.visible
