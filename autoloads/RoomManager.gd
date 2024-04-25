extends CanvasLayer

@export var animation_duration = 2.0

@onready var mask: Sprite2D = $BackBufferCopy/Mask

var level_select_room: PackedScene = preload("res://rooms/level_select_room.tscn")
var title_room: PackedScene = preload("res://rooms/title_room.tscn")
var level_1_room: PackedScene = preload("res://rooms/levels/level_1.tscn")
var level_2_room: PackedScene = preload("res://rooms/levels/level_2.tscn")
var level_3_room: PackedScene = preload("res://rooms/levels/level_3.tscn")
var level_4_room: PackedScene = preload("res://rooms/levels/level_4.tscn")
var level_5_room: PackedScene = preload("res://rooms/levels/level_5.tscn")
var level_6_room: PackedScene = preload("res://rooms/levels/level_6.tscn")
var level_7_room: PackedScene = preload("res://rooms/levels/level_7.tscn")
var level_8_room: PackedScene = preload("res://rooms/levels/level_8.tscn")

var current_room: Room
var transitioning = false

signal room_changed(room_name: String)

func change_room(room_name: String):
	var scene = get(room_name + "_room")
	if not scene:
		printerr(room_name + " is not a valid room")
		return

	if transitioning: return

	mask.scale = Vector2(2, 2)
	mask.rotation = 0

	transitioning = true
	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tween.tween_property(mask, "scale", Vector2(0, 0), animation_duration / 2)
	tween.tween_property(mask, "rotation", PI*2, animation_duration / 2)
	tween.chain().tween_property(mask, "scale", Vector2(2, 2), animation_duration / 2)
	tween.tween_property(mask, "rotation", 0, animation_duration / 2)

	await Clock.wait(animation_duration / 2)

	get_tree().change_scene_to_packed(scene)
	room_changed.emit(room_name)

	await Clock.wait(animation_duration / 2)

	transitioning = false

func play_level(level: LevelResource):
	if transitioning: return

	change_room(get_resource_name(level))
	current_room.color_palette = level.color_palette
	await Clock.wait(animation_duration / 2)
	ColorPalette.update_color_palette()

func finish_level():
	print("finish")
	var level = get_resource_name(current_room.level_resource).replace("level_", "").to_int()
	if level > load_level():
		save_level(level)

	RoomManager.change_room("level_select")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc") and not transitioning:
		if current_room is LevelRoom:
			change_room("level_select")
		else:
			get_tree().quit()

	if Input.is_action_just_pressed("restart") and current_room is LevelRoom and not transitioning:
		AudioManager.play_sound(AudioManager.restart)
		var current_level = (current_room as LevelRoom)
		change_room(get_resource_name(current_level.level_resource))

func save_level(data: int):
	var file = FileAccess.open("user://data.json", FileAccess.WRITE)
	file.store_string(str(data))
	file = null

func load_level():
	var file = FileAccess.open("user://data.json", FileAccess.READ)
	if file:
		return file.get_as_text().to_int()
	else:
		return 0

func get_resource_name(resource: Resource):
	return resource.resource_path.get_file().trim_suffix(".tres")
