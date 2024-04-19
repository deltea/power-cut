extends CanvasLayer

@onready var overlay: TextureRect = $Overlay

var colors: ColorPaletteResource

func _ready() -> void:
	update_color_palette()
	RenderingServer.set_default_clear_color(colors.dark)

func _process(_delta: float) -> void:
	update_color_palette()

func update_color_palette():
	colors = RoomManager.current_room.color_palette

	overlay.material.set_shader_parameter("new_dark", colors.dark)
	overlay.material.set_shader_parameter("new_light", colors.light)
	overlay.material.set_shader_parameter("new_primary", colors.primary)
	overlay.material.set_shader_parameter("new_secondary", colors.secondary)
