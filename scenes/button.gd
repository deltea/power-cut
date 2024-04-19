class_name ButtonInput extends InputControl

@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D

func _process(_delta: float) -> void:
	var enabled_prev = enabled
	enabled = player_touching
	if enabled != enabled_prev:
		sprite.texture = enabled_texture if enabled else disabled_texture
		Globals.camera.shake(0.05, 1)
