class_name MovingPlatform extends Path2D

@export var platform_speed = 50.0
@export var control: InputControl

@onready var follow: PathFollow2D = $PathFollow2D
@onready var line: Line2D = $Line2D
@onready var body: StaticBody2D = $PathFollow2D/StaticBody2D
@onready var sprite: Sprite2D = $PathFollow2D/StaticBody2D/Sprite2D

var enabled: bool

func _ready() -> void:
	var points = curve.get_baked_points()
	for i in range(len(points)):
		line.add_point(points[i], i)

	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)

func _physics_process(delta: float) -> void:
	var prev_position = body.global_position

	if enabled: follow.progress += platform_speed * delta

	body.constant_linear_velocity = (body.global_position - prev_position).normalized() * platform_speed

func _on_activate(value: bool):
	enabled = value
	sprite.self_modulate = Color.RED if value else Color.WHITE
