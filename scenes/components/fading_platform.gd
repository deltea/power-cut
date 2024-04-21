class_name FadingPlatform extends StaticBody2D

@export var control: InputControl
@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D

@onready var sprite: Sprite = $Sprite
@onready var collider: CollisionShape2D = $CollisionShape

func _ready() -> void:
	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)

func _on_activate(value: bool):
	sprite.texture = enabled_texture if value else disabled_texture
	collider.disabled = not value
