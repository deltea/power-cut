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
@export var push_force = 1000.0

@export_category("Animation")
@export var run_tilt_angle = 20.0
@export var squash = 0.6
@export var stretch = 0.6

@onready var sprite: Sprite = $Sprite

var jumped = false
var coyote_timer = 0.0
var buffer_timer = buffer_time
var can_move = true

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

	if can_move:
		sprite.target_rotation_degrees = x_input * run_tilt_angle
		if x_input:
			velocity.x = move_toward(velocity.x, x_input * max_speed, acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0.0, deceleration)
	else:
		sprite.target_rotation_degrees = 0
		velocity.x = 0

	if Input.is_action_just_pressed("jump") or buffer_timer < buffer_time and not jumped and can_move:
		if is_on_floor() or coyote_timer < coyote_time:
			AudioManager.play_sound(AudioManager.jump, 0.1)
			velocity.y = -jump_velocity
			sprite.scale(Vector2.ONE + Vector2(-stretch, stretch))
			jumped = true

	if Input.is_action_just_pressed("jump") and not is_on_floor():
		buffer_timer = 0.0

	if Input.is_action_just_pressed("down"):
		position.y += 2

	var was_on_floor = is_on_floor()
	move_and_slide()

	if not was_on_floor and is_on_floor():
		sprite.scale(Vector2.ONE + Vector2(squash, -squash))
		jumped = false
	elif was_on_floor and not is_on_floor() and not jumped:
		coyote_timer = 0.0

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var collider = collision.get_collider()
		if collider is RigidBody2D and position.y > collider.position.y:
			(collider as RigidBody2D).apply_force(-collision.get_normal() * push_force)

func trampolined(force: float):
	velocity.y = -force

func win(winning: Winning):
	can_move = false
	velocity = Vector2.ZERO

	sprite.rotation_dynamics_enabled = false
	sprite.scale_dynamics_enabled = false
	sprite.offset = Vector2.ZERO
	sprite.position = Vector2(0, -7)

	var tweener = get_tree().create_tween().set_parallel(true)
	tweener.tween_property(sprite, "target_scale", Vector2.ZERO, 1)
	tweener.tween_property(sprite, "global_position", winning.position, 1)
	tweener.tween_property(sprite, "rotation_degrees", 360, 1)
