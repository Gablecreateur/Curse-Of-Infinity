extends Curse

var input_direction : float
var speed : float = 100
var CanMove : bool = true

func run(delta : float) -> void:
	
	if Input.get_axis("left","right") != 0 and CanMove and !Game.player.is_on_ceiling() and !Game.player.is_on_wall():
		input_direction = Input.get_axis("left","right")
		Game.player.velocity.x = input_direction * speed * delta * Game.ACCELERATION
		Game.player.velocity.y = -speed * delta * Game.ACCELERATION
		
		
	elif not Game.player.is_on_floor():
		Game.player.velocity.y += Game.GRAVITY * delta * (Game.ACCELERATION/4)
		Game.player.velocity.x = 0
		CanMove = false
	else:
		Game.player.velocity = Vector2.ZERO
		CanMove = true
		
	Game.player.move_and_slide()
