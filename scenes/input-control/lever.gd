class_name Lever extends InputControl

@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D
@export var alt_disabled_texture: Texture2D
@export var default_enabled: bool = false
@export var alt_disabled = false

func _ready() -> void:
	set_enabled(default_enabled)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and touching:
		toggle_enabled()

func set_enabled(value: bool):
	enabled = value
	sprite.texture = enabled_texture if value else (alt_disabled_texture if alt_disabled else disabled_texture)
	sprite.scale(Vector2(1.5, 1.5))
	Globals.camera.shake(0.05, 1)

func toggle_enabled():
	AudioManager.play_sound(AudioManager.lever, 0.4)
	set_enabled(not enabled)
	activate.emit(enabled)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		touching.push_back(body)
	elif rigidbody_touch and body is RigidBody2D:
		toggle_enabled()
