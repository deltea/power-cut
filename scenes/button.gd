class_name ButtonInput extends InputControl

@export var enabled_texture: Texture2D
@export var disabled_texture: Texture2D

var enabled: bool

func _process(_delta: float) -> void:
	enabled = player_touching
	sprite.texture = enabled_texture if enabled else disabled_texture
