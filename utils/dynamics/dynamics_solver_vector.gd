class_name DynamicsSolverVector extends Node

@export_group("Dynamics")
@export var dynamics: DynamicsResource

var f: float
var z: float
var r: float

var xp: Vector2
var xd: Vector2
var y: Vector2
var yd: Vector2

var k1: float
var k2: float
var k3: float

var T: float

func _ready() -> void:
	if dynamics:
		f = dynamics.f
		z = dynamics.z
		r = dynamics.r

	k1 = z / (PI * f)
	k2 = 1 / ((2 * PI * f) * (2 * PI * f))
	k3 = r * z / (2 * PI * f)

	reset()

func _process(delta: float) -> void:
	T = delta

func update(x: Vector2):
	if xd == null:
		xd = (x - xp) / T
		xp = x

	var k2_stable = max(k2, T * T / 2 + T * k1 / 2, T * k1)
	y = y + T * yd
	yd = yd + T * (x + k3 * xd - y - k1 * yd) / k2_stable

	return y

func reset():
	xp = Vector2.ZERO
	xd = Vector2.ZERO
	y = Vector2.ZERO
	yd = Vector2.ZERO

func set_value(new_value: Vector2):
	reset()
	y = new_value
