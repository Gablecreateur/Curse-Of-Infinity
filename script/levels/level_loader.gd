extends Node2D

func _ready() -> void:
	
	Game.level_parent = self
	Game.start_level()
