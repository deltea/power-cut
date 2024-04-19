class_name ExitDoor extends Area2D

@export var control: InputControl
@export var inverted = false

@onready var sprite: Sprite = $Sprite
@onready var particles: CPUParticles2D = $CPUParticles

func _ready() -> void:
	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)
	else:
		_on_activate(true)

func _on_activate(value: bool):
	sprite.self_modulate = Color.RED if value else Color.WHITE
	particles.color = Color.RED if value else Color.WHITE
	particles.emitting = value
