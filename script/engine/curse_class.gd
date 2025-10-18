extends Node
class_name Curse

enum TARGETS {
	PLAYER_MOUVEMENT,
	PLAYER_APPEARENCE,
	LEVEL_GAMEPLAY,
	LEVEL_APPEARENCE,
	LEVEL_SCENE
}

var curse_name : String
var level_duration : int
var id : StringName

var target : Array[TARGETS]

func start() -> void:
	pass

func _run() -> void:
	pass

func end() -> void:
	pass
