extends Curse

var default_gravity : float

func start() -> void:
	default_gravity = Game.GRAVITY
	Game.GRAVITY *= 0.5

func run(delta : float) -> void:
	
	Game.player.movement_manager(delta)
	if not Game.player.is_on_floor():
		Game.player.velocity.x += randf_range(-100.0,100.0)
	
	Game.player.move_and_slide()

func end() -> void:
	Game.GRAVITY = default_gravity
