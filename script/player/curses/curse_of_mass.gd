extends Curse

var ceiling_damage : int = 0
var is_brocken : bool = false

func start() -> void:
	Game.player.speed *= 0.125
	Game.player.jump_height = 8
	Game.player.connect("jumped",break_ceilling)

func run(delta : float) -> void:
	
	Game.player_default_behavior.call(delta)
	
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.speed = Game.player.default_speed

func break_ceilling() -> void:
	if not is_brocken:
		ceiling_damage += 1
		$Level/GPUParticles2D.emitting = true
		$Level/GPUParticles2D2.emitting = true
		
		if ceiling_damage >= 5:
			is_brocken = true
			$Level/GPUParticles2D3.emitting = true
			$Level/BrockenFallingCeiling.position.y = -80
			$Level/Button.push_button()
