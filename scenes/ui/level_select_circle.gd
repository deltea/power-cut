class_name LevelSelectCircle extends Node2D

@export var level_resource: LevelResource
@export var num = 0

@onready var sprite: Sprite = $Sprite
@onready var border: Sprite2D = $Sprite/Border
@onready var completed_indicator: Sprite2D = $Sprite/Complete
@onready var locked_indicator: Sprite2D = $Sprite/Locked
@onready var title_label: Label = $Sprite/Title
@onready var num_label: Label = $Sprite/Num

var completed = false
var locked = false
var bottom_title = false
var selected = false:
	get: return selected
	set(value):
		selected = value
		border.visible = value

func update():
	title_label.text = level_resource.name
	num_label.text = str(num)
	completed_indicator.visible = completed
	locked_indicator.visible = locked
	title_label.position.y = 18 if bottom_title else -30
