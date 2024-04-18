class_name Camera extends Camera2D

@export var zoom_speed = 5.0
@export var mouse_strength = 0.05
@export var player_x_strength = 0.0
@export var rotation_speed = 5.0
@export var impact_rotation = 5.0
@export var shake_damping_speed = 2.0
@export var jerk_damping_speed = 150.0

var shake_duration = 0;
var shake_magnitude = 0;
var original_pos = Vector2.ZERO;
var target_zoom = Vector2.ONE
var target_jerk = Vector2.ZERO
var jerk = Vector2.ZERO

func _enter_tree() -> void:
	Globals.camera = self

func _ready() -> void:
	original_pos = position
	zoom = Vector2(5, 5)

	limit_top = -RoomManager.current_room.limit_y
	limit_bottom = RoomManager.current_room.limit_y
	limit_left = -RoomManager.current_room.limit_x
	limit_right = RoomManager.current_room.limit_x

func _process(delta: float) -> void:
	offset = (get_global_mouse_position() - global_position) * mouse_strength + jerk
	zoom = lerp(zoom, target_zoom, zoom_speed * delta)
	jerk = jerk.move_toward(target_jerk, jerk_damping_speed * delta)

	if Globals.player:
		var player_x_tilt = 0 - Globals.player.position.x * player_x_strength
		rotation_degrees = lerp(rotation_degrees, 0.0 + player_x_tilt, rotation_speed * delta)

	if shake_duration > 0:
		position = original_pos + Vector2.from_angle(randf_range(0, PI*2)) * shake_magnitude
		shake_duration -= delta * shake_damping_speed
	else:
		shake_duration = 0
		position = original_pos

func shake(duration: float, magnitude: float):
	shake_duration = duration
	shake_magnitude = magnitude

func impact():
	rotation_degrees = (1 if randf() > 0.5 else -1) * impact_rotation

func jerk_direction(direction: Vector2, magnitude: float):
	target_jerk = direction.normalized() * magnitude
	await Clock.wait(0.1)
	target_jerk = Vector2.ZERO
