extends Node

const ACCELERATION : float = 25
const GRAVITY : float = 50

var player : Player
var base_level : Node2D
var current_level : Level
var level_parent : Node2D
var active_checkpoint : Node2D
var level_loader : Node2D

var player_default_behavior : Callable
var curse_manager : CurseManager
var default_curse : Curse
var active_curse_array : Array[Curse]
var total_curse_dict : Dictionary[StringName,Curse]

var level_modifier : Curse
var gameplay_modifier : Curse
var appearence_modifier : Curse

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
	
	curse_manager.load_curse(&"no_curse")
	curse_manager.add_curse_to_player(&"no_curse")
	
	curse_manager.load_curse(&"curse_of_mass")
	curse_manager.add_curse_to_player(&"curse_of_mass")

func _physics_process(delta: float) -> void:
	

	for curse in active_curse_array:
		curse.run(delta)

func start_level() -> void:
	
	for curse in active_curse_array:
		curse._ready()
		
		if curse.tags.has(Curse.TARGETS.LEVEL_SCENE):
			level_modifier = curse
			current_level = curse.level_scene.instantiate()
			for child in level_parent.get_children():
				if child is Level:
					child.queue_free()
			
			level_parent.add_child(current_level)
			current_level.set_checkpoint()
			active_checkpoint = current_level.checkpoint
		
		if curse.tags.has(Curse.TARGETS.PLAYER_APPEARENCE):
			appearence_modifier = curse
		
		if curse.tags.has(Curse.TARGETS.PLAYER_MOUVEMENT_MODIFIER) or curse.tags.has(Curse.TARGETS.PLAYER_MOUVEMENT_OVERHAUL):
			gameplay_modifier = curse
	
	start_round()


func start_round() -> void:
	print("Active checkpoint :")
	print(Game.active_checkpoint)
	#Game.player.position = Game.active_checkpoint.position
