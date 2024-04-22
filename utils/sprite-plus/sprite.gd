class_name Sprite extends Sprite2D

signal flash_finished

@export_group("Dynamics")
@export var scale_dynamics_enabled = true
@export var scale_dynamics: DynamicsResource
@export var rotation_dynamics_enabled = true
@export var rotation_dynamics: DynamicsResource

@onready var flash_timer: Timer = $FlashTimer
@onready var scale_dynamics_solver := Globals.create_dynamics_vector(scale_dynamics)
@onready var rotation_dynamics_solver := Globals.create_dynamics(rotation_dynamics)

var target_scale = Vector2.ONE
var target_rotation_degrees = 0.0
var shadow: Sprite2D

func _ready() -> void:
	target_scale = global_scale
	target_rotation_degrees = global_rotation_degrees

func _process(_delta: float) -> void:
	if scale_dynamics and scale_dynamics_enabled:
		global_scale = scale_dynamics_solver.update(target_scale)
	else:
		global_scale = target_scale

	if rotation_dynamics and rotation_dynamics_enabled:
		global_rotation_degrees = rotation_dynamics_solver.update(target_rotation_degrees)
	else:
		global_rotation_degrees = target_rotation_degrees

func scale(value: Vector2):
	scale_dynamics_solver.set_value(value)

func rotation(value: float):
	rotation_dynamics_solver.set_value(value)

func flash(interval: float = 0.1, duration = 0):
	flash_timer.wait_time = interval
	flash_timer.start()
	if duration > 0:
		await Globals.wait(duration)
		stop_flash()

func stop_flash():
	flash_finished.emit()
	flash_timer.stop()
	visible = true

func _on_flash_timer_timeout() -> void:
	visible = not visible
