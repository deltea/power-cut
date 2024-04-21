class_name Door extends StaticBody2D

enum Direction { TOP, BOTTOM }

@export var direction = Direction.TOP
@export var scale_dynamics: DynamicsResource
@export var control: InputControl
@export var inverted = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var scale_dynamics_solver := Globals.create_dynamics(scale_dynamics)
@onready var collider: CollisionShape2D = $CollisionShape

var open = false

func _ready() -> void:
	var offset = 16 if direction == Direction.TOP else -16
	sprite.offset.y = offset
	sprite.position = Vector2(0, -offset)

	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)

func _on_activate(value: bool):
	open = value if inverted else not value
	collider.disabled = not value if inverted else value

func _process(_delta: float) -> void:
	sprite.scale.y = scale_dynamics_solver.update(1 if open else 0)
