extends CharacterBody2D
class_name Player

var speed : float = 200.0
var jump_height : float = 15.0

signal jumped

@onready var hurtbox : Hurtbox = $Hurtbox
var default_speed : float
var default_jump_height : float

func _ready() -> void:
	default_jump_height = jump_height
	default_speed = speed


func movement_manager(delta : float) -> void:
	
	var horizontal_dir : float = Input.get_axis("left","right")
	velocity.x = horizontal_dir * speed * delta * Game.ACCELERATION
	
	if not Game.player.is_on_floor():
		velocity.y += Game.GRAVITY * delta * (Game.ACCELERATION/4)
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("jump") && Game.player.is_on_floor():
		velocity.y = -jump_height * (Game.ACCELERATION/2)
		jumped.emit()
