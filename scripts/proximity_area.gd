class_name ProximityArea extends Area2D

@export var rigidbody_touch = false

var player_touching = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		player_touching = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		player_touching = false
