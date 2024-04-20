class_name Trail extends Line2D

@export var emitting = true
@export var length = 10.0

var queue: Array[Vector2]

func _process(_delta: float) -> void:
	if not emitting: return

	queue.push_front(get_parent().global_position)

	if queue.size() > length:
		queue.pop_back()

	clear_points()
	for point in queue:
		add_point(point)
