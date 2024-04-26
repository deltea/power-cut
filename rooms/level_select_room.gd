class_name LevelSelect extends Room

@export var camera_dynamics: DynamicsResource
@export var select_circles_parent: Node2D
@export var dotted_line_padding = 30.0
@export var stars_parallax = 0.8
@export var stars_amount = 100
@export var stars_box: Vector2 = Vector2(5000, 500)
@export var level_offset = 4

@onready var camera: Camera = $Camera
@onready var stars: Node2D = $Stars
@onready var camera_dynamics_solver := Globals.create_dynamics_vector(camera_dynamics)

var index = 0
var camera_target_position = Vector2.ZERO
var select_circles: Array[LevelSelectCircle] = []
var dotted_line_scene = preload("res://scenes/dotted_line.tscn")
var star_scene = preload("res://scenes/star.tscn")

func _ready() -> void:
	var level = RoomManager.load_level()
	index = level + level_offset

	# AudioManager.play_music(AudioManager.level_select_music)

	for child in select_circles_parent.get_children():
		if child is LevelSelectCircle:
			select_circles.push_back(child)

	# Setting the circles
	for i in range(len(select_circles)):
		if i < level + level_offset:
			select_circles[i].completed = true
		elif i > level + level_offset:
			select_circles[i].locked = true
		select_circles[i].update()

	# Adding dotted lines
	for x in range(len(select_circles)):
		if x == len(select_circles) - 1: break

		var circle = select_circles[x]
		var next_circle = select_circles[x + 1]
		var normal = (circle.position - next_circle.position).normalized()

		select_circles[x].bottom_title = circle.position.y >= next_circle.position.y
		select_circles[x].update()

		var dotted_line = dotted_line_scene.instantiate() as Line2D
		var offset = normal * dotted_line_padding
		dotted_line.add_point(circle.position - offset, 0)
		dotted_line.add_point(next_circle.position + offset, 1)
		dotted_line.self_modulate = Color.RED
		add_child(dotted_line)

	# Adding the stars
	for j in range(stars_amount):
		var star = star_scene.instantiate() as Sprite2D
		var x = randf_range(-700, stars_box.x)
		var y = randf_range(-stars_box.y / 2, stars_box.y / 2)
		star.position = Vector2(x - 240, y)
		stars.add_child(star)

	update_selection()

func update_selection(value: int = 0):
	var prev_index = clampi(index, 0, len(select_circles) - 1)
	select_circles[prev_index].selected = false

	index = clampi(index + value, 0, len(select_circles) - 1)
	select_circles[index].selected = true
	camera_target_position = select_circles[index].position
	color_palette = select_circles[index].level_resource.color_palette
	ColorPalette.update_color_palette()

func _process(_delta: float) -> void:
	camera.position = camera_dynamics_solver.update(camera_target_position)
	stars.position = -camera.position * stars_parallax

	var input = 0
	if Input.is_action_just_pressed("left"): input -= 1
	if Input.is_action_just_pressed("right"): input += 1

	if input:
		AudioManager.play_sound(AudioManager.level_selection, 0.1)
		update_selection(input)

	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("jump"):
		select_circles[index].press()

		if select_circles[index].locked:
			AudioManager.play_sound(AudioManager.level_locked)
			camera.shake(0.1, 2)
		elif select_circles[index] is WinSelectCircle:
			AudioManager.play_sound(AudioManager.win)
			select_circles[index].confetti_explosion()
		elif select_circles[index] is VolumeSelectCircle:
			AudioManager.play_sound(AudioManager.lever, 0.2)
			AudioManager.change_volume()
			select_circles[index].title_label.text = str(AudioManager.volume) + "%"
		elif select_circles[index] is GithubSelectCircle:
			AudioManager.play_sound(AudioManager.lever, 0.2)
			OS.shell_open("https://github.com/thcheetah777/power-cut")
		elif select_circles[index] is FullscreenSelectCircle:
			AudioManager.play_sound(AudioManager.lever, 0.2)
			var fullscreen = toggle_fullscreen()
			select_circles[index].title_label.text = "Yes" if fullscreen else "No"
		elif select_circles[index] is DeleteSelectCircle:
			AudioManager.play_sound(AudioManager.lever, 0.2)
			RoomManager.save_level(0)
			RoomManager.change_room("level_select")
		else:
			AudioManager.play_sound(AudioManager.level_selected)
			RoomManager.play_level(select_circles[index].level_resource)

func toggle_fullscreen() -> bool:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		return false
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return true
