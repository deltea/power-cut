class_name Box extends RigidBody2D

@export var drag = 10.0

@onready var area: Area2D = $Area2D

func _process(_delta: float) -> void:
	var bodies = area.get_overlapping_bodies().filter(func(x): return not x is Box)
	linear_damp = drag if len(bodies) > 0 else 0.0

func _on_area_2d_body_entered(_body: Node2D) -> void:
	AudioManager.play_sound(AudioManager.box)
