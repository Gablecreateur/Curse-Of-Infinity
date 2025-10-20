extends Node2D

@export var linked_interactible : Interactible

func _ready() -> void:
	linked_interactible.connect(&"activated",open_door)
	$LockedDoorSprite2D.visible = true
	$UnlockedDoorSprite2D.visible = false

func open_door() -> void:
	$LockedDoorSprite2D.visible = false
	$UnlockedDoorSprite2D.visible = true
