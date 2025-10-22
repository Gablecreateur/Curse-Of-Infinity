extends Node2D
class_name Interactible

var IsActivated : bool = false
signal activated

func _ready() -> void:
	$TopSprite2D.visible = true
	Game.player.hurtbox.connect("died",reset_button)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Game.player:
		push_button()


func push_button() -> void:
	IsActivated = true
	activated.emit()
	$TopSprite2D.visible = false

func reset_button() -> void:
	IsActivated = false
	$TopSprite2D.visible = true
