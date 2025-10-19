extends Camera2D


func _process(delta: float) -> void:
	position.x = Game.player.position.x
