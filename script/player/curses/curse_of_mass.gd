extends Curse

var ceiling_damage : int = 0
var is_brocken : bool = false

func _ready() -> void:
	level_scene = load("res://scenes/levels/curse_of_mass_level.tscn")

func start() -> void:
	Game.player.speed = 20
	Game.player.jump_height = 8
	Game.player.connect("jumped",break_ceilling)
	Game.base_level.visible = false

func run(delta : float) -> void:
	
	Game.player_default_behavior.call(delta)
	
	Game.player.move_and_slide()

func end() -> void:
	Game.player.speed = Game.player.default_speed
	Game.base_level.visible = true
	Game.current_level.visible = true
	$Level.visible = false

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
