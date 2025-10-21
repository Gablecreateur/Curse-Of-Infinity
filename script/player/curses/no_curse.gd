extends Curse

@export var player_speed : float
@export var jump_height : float


func _init() -> void:
	Game.player_default_behavior = run
	

func run(delta : float) -> void:
	
	Game.player.movement_manager(delta)
	
	Game.player.move_and_slide()
