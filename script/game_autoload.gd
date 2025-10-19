extends Node

const ACCELERATION : float = 400
const GRAVITY : float = 50

var player : CharacterBody2D
var base_level : Node2D
var current_level : Node2D

var curse_manager : CurseManager
var default_curse : Curse
var active_curse_array : Array[Curse]
var total_curse_dict : Dictionary[StringName,Curse]


var gravity : Vector2 = Vector2(0,1)
const DEFAULT_GRAVITY : Vector2 = Vector2(0,1)

func load_and_add_to_tree(parent : Node,path : NodePath):
	var packed_scene : PackedScene = load(path)
	var instance = packed_scene.instantiate()
	parent.add_child(instance)
	return instance

func _ready() -> void:
	curse_manager = load_and_add_to_tree(self,"res://scenes/game/curse_manager.tscn")
	default_curse = curse_manager.loaded_curse_dict[&"no_curse"]
	player = load_and_add_to_tree(self,"res://scenes/player/player.tscn")
	print(player)

func _physics_process(delta: float) -> void:
	default_curse.run(delta)
