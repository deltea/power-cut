extends Node

var current_room: Room

signal room_changed(room_name: String)

func change_room(room_name: String):
	var scene = get(room_name + "_room")
	if not scene:
		printerr(room_name + " is not a valid room")
		return

	get_tree().change_scene_to_packed(scene)
	room_changed.emit(room_name)
