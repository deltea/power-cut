class_name InputControl extends Area2D

signal activate

@onready var sprite: Sprite = $Sprite

var player_touching = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player: player_touching = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player: player_touching = false
