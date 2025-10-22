extends Curse

var IsJumping : bool = false
var CanMove : bool = true

var jump_height : float = 15.0
var velocity : Vector2



func run(delta : float) -> void:
	

	if not Game.player.is_on_floor():
		Game.player.velocity.y += Game.GRAVITY * delta * (Game.ACCELERATION/4)
	
	elif Game.player.is_on_floor():
		Game.player.velocity = Vector2.ZERO
		IsJumping = false
		CanMove = true
	
	if Input.is_action_just_pressed("jump") && Game.player.is_on_floor():
		Game.player.velocity.y = -jump_height * (Game.ACCELERATION/2)
		Game.player.jumped.emit()
		IsJumping = true
	
	if IsJumping && CanMove && Input.get_axis("left","right") != 0:
		Game.player.velocity.x = Input.get_axis("left","right") * (Game.ACCELERATION/2) * jump_height
		CanMove = false
	
	Game.player.move_and_slide()
