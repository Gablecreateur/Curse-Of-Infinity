extends Node
class_name Curse

enum TARGETS {
	PLAYER_MOUVEMENT_MODIFIER,
	PLAYER_MOUVEMENT_OVERHAUL,
	PLAYER_APPEARENCE,
	LEVEL_SCENE
}

@export var curse_name : String
@export var level_duration : int = 1
@export var id : StringName
@export var level_node : Level
var level_scene : PackedScene

@export var tags : Array[TARGETS]

func _ready() -> void:
	if level_node != null:
		level_scene = PackedScene.new()
		level_scene.pack(level_node.duplicate())
		

func start() -> void:
	pass

func run(delta : float) -> void:
	pass

func end() -> void:
	pass
