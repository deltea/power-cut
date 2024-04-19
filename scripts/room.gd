class_name Room extends Node2D

@export var color_palette: ColorPaletteResource

@export_category("Camera Limits")
@export var limit_x = 240
@export var limit_y = 135

func _enter_tree() -> void:
	RoomManager.current_room = self
