extends CanvasLayer

@onready var overlay: TextureRect = $Overlay

var colors: ColorPaletteResource

func _ready() -> void:
	colors = RoomManager.current_room.color_palette

	RenderingServer.set_default_clear_color(colors.dark)
	overlay.material.set_shader_parameter("new_dark", colors.dark)
	overlay.material.set_shader_parameter("new_light", colors.light)
	overlay.material.set_shader_parameter("new_primary", colors.primary)
	overlay.material.set_shader_parameter("new_secondary", colors.secondary)
