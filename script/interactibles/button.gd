extends Node2D
class_name Interactible

var IsActivated : bool = false
signal activated

func _ready() -> void:
	$TopSprite2D.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Game.player:
		IsActivated = true
		activated.emit()
		$TopSprite2D.visible = false
