extends Curse

func start() -> void:
	Game.player.scale = Vector2(0.25,0.25)

func run(delta : float) -> void:
	
	Game.player.movement_manager(delta)
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.scale = Vector2(1,1)
