class_name Lever extends InputControl

@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D
@export var default_enabled: bool = false

var enabled: bool

func _ready() -> void:
	set_enabled(false)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_touching:
		activate.emit()

func _on_activate() -> void:
	set_enabled(not enabled)

func set_enabled(value: bool):
	enabled = value
	sprite.texture = enabled_texture if value else disabled_texture
	sprite.scale(Vector2(1.5, 1.5))
	Globals.camera.shake(0.08, 1)
