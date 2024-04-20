class_name LevelRoom extends Room

@export var level_resource: LevelResource

func _enter_tree() -> void:
	super._enter_tree()
	color_palette = level_resource.color_palette
