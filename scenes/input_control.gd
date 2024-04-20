class_name InputControl extends Area2D

signal activate(value: bool)

@export var power_line: PowerLine
@export var rigidbody_touch = false

@onready var sprite: Sprite = $Sprite

var player_touching = false
var enabled: bool:
	get: return enabled
	set(value):
		enabled = value
		on_set_enabled()

func _on_body_entered(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		player_touching = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		player_touching = false

func on_set_enabled():
	if power_line:
		power_line.default_color = Color.RED if enabled else Color.WHITE
