extends Curse

@export var player_speed : float
@export var jump_height : float


func _init() -> void:
	curse_name = "No Curse"


func run(delta : float) -> void:
	
	movement_manager(delta)
	jumping_manager(delta)
	
	Game.player.move_and_slide()

func movement_manager(delta : float) -> void:
	
	var horizontal_dir : float = Input.get_axis("left","right")
	Game.player.velocity.x = horizontal_dir * player_speed * delta * Game.ACCELERATION
	print(Game.player.velocity)
	
func jumping_manager(delta : float) -> void:
	
	
		
	if not Game.player.is_on_floor():
		Game.player.velocity.y += Game.GRAVITY * delta * (Game.ACCELERATION/4)
	else:
		Game.player.velocity.y = 0
	
	if Input.is_action_just_pressed("jump"):
		Game.player.velocity.y = -jump_height * (Game.ACCELERATION/2)
