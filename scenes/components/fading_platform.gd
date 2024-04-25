class_name FadingPlatform extends StaticBody2D

@export var control: InputControl
@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D
@export var inverted = false

@onready var sprite: Sprite = $Sprite
@onready var collider: CollisionShape2D = $CollisionShape

var enabled = false

func _ready() -> void:
	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)

func _on_activate(value: bool):
	enabled = not value if inverted else value
	sprite.set_deferred("texture", enabled_texture if enabled else disabled_texture)
	collider.set_deferred("disabled", not enabled)
