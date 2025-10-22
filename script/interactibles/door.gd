extends Node2D

@export var linked_interactible : Interactible
var IsOpen : bool = false

func _ready() -> void:
	close_door()
	linked_interactible.connect(&"activated",open_door)
	Game.player.hurtbox.connect("died",close_door)
	

func open_door() -> void:
	$LockedDoorSprite2D.visible = false
	$UnlockedDoorSprite2D.visible = true
	IsOpen = true

func close_door() -> void:
	$LockedDoorSprite2D.visible = true
	$UnlockedDoorSprite2D.visible = false
	IsOpen = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if IsOpen and body is Player:
		Game.end_level()
