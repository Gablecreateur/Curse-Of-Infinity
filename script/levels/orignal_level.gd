extends Node2D
class_name Level

@export var checkpoint : Node2D

func set_checkpoint() -> void:
	Game.active_checkpoint = checkpoint
