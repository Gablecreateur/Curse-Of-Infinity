extends Area2D
class_name Hurtbox

@export var max_health : int = 1
var health : int = max_health

signal died

func _ready() -> void:
	connect("area_entered",_on_area_entered)

func damage(amount : int) -> void:
	
	if (health - amount) <= 0:
		health = 0
		die()
	
	else:
		health -= amount


func _on_area_entered(area: Area2D) -> void:
	
	if area is Hitbox:
		self.damage(area.damage)

func die() -> void:
	print(str(owner.name) + " died")
	died.emit()
