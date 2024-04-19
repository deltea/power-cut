class_name InputControl extends Area2D

@export var connection: Node2D

signal activate

@onready var sprite: Sprite = $Sprite

var player_touching = false
var enabled: bool

func _on_body_entered(body: Node2D) -> void:
	if body is Player: player_touching = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player: player_touching = false
