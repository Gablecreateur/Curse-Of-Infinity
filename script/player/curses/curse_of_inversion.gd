extends Curse

func start() -> void:
	Game.player.connect("jumped",switch_gravity)

func run(delta : float) -> void:
	
	Game.player.movement_manager(delta)
	
	if Game.player.is_on_ceiling() && Input.is_action_just_pressed("jump"):
		switch_gravity()
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.jumped.disconnect(switch_gravity)
	Game.GRAVITY = 50

func switch_gravity() -> void:
	Game.GRAVITY *= -1
