class_name Winning extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.player.win(self)
		# RoomManager.change_room("win")
