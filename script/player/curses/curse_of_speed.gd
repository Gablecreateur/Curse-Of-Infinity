extends Curse

func _ready() -> void:
	tags = [TARGETS.PLAYER_MOUVEMENT_MODIFIER]

func start() -> void:
	Game.player.speed *= 2

func run(delta : float) -> void:
	
	Game.player_default_behavior.call(delta)
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.speed = Game.player.default_speed
