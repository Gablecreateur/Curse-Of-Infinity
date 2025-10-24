extends Curse

func run(delta : float) -> void:
	
	Game.player.movement_manager(delta)
	
	if is_zero_approx(Game.player.velocity.x) && is_zero_approx(Game.player.velocity.y):
		Game.player.visible = true
	else:
		Game.player.visible = false
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.visible = true
