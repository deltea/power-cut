class_name ProximityArea extends Area2D

@export var rigidbody_touch = false

var touching: Array[Node2D]

func _on_body_entered(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		touching.push_back(body)

func _on_body_exited(body: Node2D) -> void:
	if body is Player or (rigidbody_touch and body is RigidBody2D):
		var index = touching.find(body)
		if index != -1:
			touching.remove_at(index)
