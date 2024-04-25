class_name Trampoline extends Area2D

@export var force = 500.0
@export var control: InputControl
@export var inverted = false

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
		AudioManager.play_sound(AudioManager.trampoline, 0.2)
		sprite.scale(Vector2(1.2, 1.2))
		Globals.player.trampolined(force)

func _on_activate(value: bool):
	enabled = not value if inverted else value
	sprite.self_modulate = Color.RED if enabled else Color.WHITE
	sprite.scale(Vector2(1.2, 1.2))
