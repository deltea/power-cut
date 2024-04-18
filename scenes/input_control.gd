class_name InputControl extends Area2D

signal activate

@onready var sprite: Sprite = $Sprite

var player_touching = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player: player_touching = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player: player_touching = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_touching:
		activate.emit()
