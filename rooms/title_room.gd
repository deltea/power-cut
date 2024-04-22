class_name TitleRoom extends Room

@export var color_palettes: Array[ColorPaletteResource]

func _enter_tree() -> void:
	super._enter_tree()
	color_palette = color_palettes.pick_random()
