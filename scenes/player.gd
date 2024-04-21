class_name Player extends CharacterBody2D

@export_category("Movement")
@export var max_speed = 150.0
@export var jump_velocity = 380.0
@export var gravity = 1200.0
@export var fall_gravity = 2000.0
@export var wall_fall_velocity = 80.0
@export var acceleration = 50.0
@export var deceleration = 30.0
@export var coyote_time = 0.15
@export var buffer_time = 0.15
@export var push_force = 200

@export_category("Animation")
@export var run_tilt_angle = 20.0
@export var squash = 0.6
@export var stretch = 0.6

@onready var sprite: Sprite = $Sprite

var jumped = false
var coyote_timer = 0.0
var buffer_timer = buffer_time

func _enter_tree() -> void:
	Globals.player = self

func _physics_process(delta: float) -> void:
	coyote_timer += delta
	buffer_timer += delta

	var x_input := Input.get_axis("left", "right")

	if not is_on_floor():
		if velocity.y > 0:
			if is_on_wall() and x_input:
				velocity.y = wall_fall_velocity
			else:
				velocity.y += fall_gravity * delta
		else:
			velocity.y += gravity * delta

	sprite.target_rotation_degrees = x_input * run_tilt_angle
	if x_input:
		velocity.x = move_toward(velocity.x, x_input * max_speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration)

	if Input.is_action_just_pressed("jump") or buffer_timer < buffer_time and not jumped:
		if is_on_floor() or coyote_timer < coyote_time:
			velocity.y = -jump_velocity
			sprite.scale(Vector2.ONE + Vector2(-stretch, stretch))
			jumped = true

	if Input.is_action_just_pressed("jump") and not is_on_floor():
		buffer_timer = 0.0

	var was_on_floor = is_on_floor()
	move_and_slide()

	if not was_on_floor and is_on_floor():
		sprite.scale(Vector2.ONE + Vector2(squash, -squash))
		jumped = false
	elif was_on_floor and not is_on_floor() and not jumped:
		coyote_timer = 0.0

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		if collision.get_collider() is RigidBody2D:
			(collision.get_collider() as RigidBody2D).apply_impulse(-collision.get_normal() * push_force)

func trampolined(force: float):
	velocity.y = -force
