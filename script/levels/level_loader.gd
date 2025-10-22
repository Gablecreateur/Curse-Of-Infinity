extends Node2D

func _ready() -> void:
	
	Game.level_parent = self
	Game.hud_parent  = $"../CanvasLayer/HUDParent"
	Game.start_level()
