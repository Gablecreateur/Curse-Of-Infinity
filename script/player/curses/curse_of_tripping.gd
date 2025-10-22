extends Curse


func run(delta : float) -> void:
	var horizontal_dir : float = Input.get_axis("right","jump")
	Game.player.velocity.x = horizontal_dir * Game.player.speed * delta * Game.ACCELERATION
	
	if not Game.player.is_on_floor():
		Game.player.velocity.y += Game.GRAVITY * delta * (Game.ACCELERATION/4)
	else:
		Game.player.velocity.y = 0
	
	if Input.is_action_just_pressed("left") && Game.player.is_on_floor():
		Game.player.velocity.y = -Game.player.jump_height * (Game.ACCELERATION/2)
		Game.player.jumped.emit()
	
	Game.player.move_and_slide()
