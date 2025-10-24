extends Node2D

func _ready() -> void:
	
	Game.level_parent = self
	Game.camera = $"../CanvasLayer/Camera2D"
	Game.hud_parent  = $"../CanvasLayer/HUDParent"
	Game.current_level = $"Original Level"
	Game.start_level()
