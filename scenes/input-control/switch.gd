class_name Switch extends InputControl

@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D
@export var default_enabled: bool = false

func _ready() -> void:
	set_enabled(default_enabled)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and touching:
		AudioManager.play_sound(AudioManager.lever, 0.4)
		set_enabled(not enabled)
		activate.emit(enabled)

func set_enabled(value: bool):
	enabled = value
	sprite.texture = enabled_texture if value else disabled_texture
	sprite.scale(Vector2(1.5, 1.5))
	Globals.camera.shake(0.05, 1)
