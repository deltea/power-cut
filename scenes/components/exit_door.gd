class_name ExitDoor extends ProximityArea

@export var control: InputControl
@export var inverted = false

@onready var sprite: Sprite = $Sprite
@onready var particles: CPUParticles2D = $CPUParticles

func _ready() -> void:
	if control:
		control.activate.connect(_on_activate)
		_on_activate(control.enabled)
	else:
		_on_activate(true)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and touching and (control.enabled if control else true):
		Globals.player.can_move = false
		RoomManager.finish_level()

func _on_activate(value: bool):
	var val = not value if inverted else value
	sprite.scale(Vector2(1.2, 1.2))
	sprite.self_modulate = Color.RED if val else Color.WHITE
	particles.color = Color.RED if val else Color.WHITE
	particles.visible = val
