class_name WinSelectCircle extends LevelSelectCircle

@onready var win_icon: Sprite2D = $Sprite/WinIcon

var confetti_scene = preload("res://scenes/particles/confetti.tscn")

func update() -> void:
	locked_indicator.visible = locked
	win_icon.visible = not locked_indicator.visible

func confetti_explosion():
	title_label.text = "You Win!"

	var confetti = confetti_scene.instantiate() as GPUParticles2D
	confetti.emitting = true
	confetti.position = Vector2.ZERO
	confetti.finished.connect(confetti.queue_free)
	add_child(confetti)
