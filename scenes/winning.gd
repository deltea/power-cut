class_name Winning extends Area2D

@export var float_speed = 2.0
@export var float_magnitude = 3.0

var original_position: Vector2

func _ready() -> void:
	original_position = position

func _process(_delta: float) -> void:
	position.y = original_position.y + sin(float_speed * Clock.time) * float_magnitude

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.player.win(self)
		await Clock.wait(1.0)
		RoomManager.finish_level()
