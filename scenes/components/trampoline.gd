class_name Trampoline extends Area2D

@export var force = 500.0
@export var control: InputControl

@onready var sprite: Sprite = $Sprite

var enabled: bool

func _ready() -> void:
	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)
	else:
		_on_activate(true)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and enabled:
		sprite.scale(Vector2(1.2, 1.2))
		Globals.player.trampolined(force)

func _on_activate(value: bool):
	enabled = value
	sprite.self_modulate = Color.RED if value else Color.WHITE
	sprite.scale(Vector2(1.2, 1.2))
