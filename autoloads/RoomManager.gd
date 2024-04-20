extends CanvasLayer

@export var animation_duration = 2.0

@onready var mask: Sprite2D = $BackBufferCopy/Mask

var level_select_room: PackedScene = preload("res://rooms/level_select_room.tscn")
var level_1_room: PackedScene = preload("res://rooms/levels/level_1.tscn")
var level_2_room: PackedScene = preload("res://rooms/levels/level_2.tscn")
var level_3_room: PackedScene = preload("res://rooms/levels/level_3.tscn")
var level_4_room: PackedScene = preload("res://rooms/levels/level_4.tscn")
var level_5_room: PackedScene = preload("res://rooms/levels/level_5.tscn")

var current_room: Room

signal room_changed(room_name: String)

func change_room(room_name: String):
	var scene = get(room_name + "_room")
	if not scene:
		printerr(room_name + " is not a valid room")
		return

	mask.scale = Vector2(2, 2)
	mask.rotation = 0

	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(mask, "scale", Vector2(0, 0), animation_duration / 2)
	tween.tween_property(mask, "rotation", PI*2, animation_duration / 2)
	tween.chain().tween_property(mask, "scale", Vector2(2, 2), animation_duration / 2)
	tween.tween_property(mask, "rotation", 0, animation_duration / 2)

	await Clock.wait(animation_duration / 2)

	get_tree().change_scene_to_packed(scene)
	room_changed.emit(room_name)

func play_level(level: LevelResource):
	change_room(level.resource_path.get_file().trim_suffix(".tres"))
	current_room.color_palette = level.color_palette
	await Clock.wait(animation_duration / 2)
	ColorPalette.update_color_palette()
