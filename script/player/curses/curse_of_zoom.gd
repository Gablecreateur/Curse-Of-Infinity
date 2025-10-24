extends Curse

func _ready() -> void:
	Game.player.hurtbox.connect("died",reset)

func run(delta : float) -> void:
	Game.camera.zoom += Vector2(delta,delta)/7
	
	Game.player.movement_manager(delta)
	Game.player.move_and_slide()

func end() -> void:
	Game.camera.zoom = Vector2(2,2)

func reset() -> void:
	Game.camera.zoom = Vector2(2,2)
