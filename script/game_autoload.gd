extends Node



const ACCELERATION : float = 25
var GRAVITY : float = 50
var camera : Camera2D
var paused : bool

var progress : int = 0
var player : Player
var player_lives : int = 10
var base_level : Level
var current_level : Level
var level_parent : Node2D
var active_checkpoint : Node2D
var level_loader : Node2D
var hud_parent : Control

var player_default_behavior : Callable
var curse_manager : CurseManager
var default_curse : Curse
var current_curse : Curse
var total_curse_dict : Dictionary[StringName,Curse]
var curse_id_array : Array[String]
var curse_left_id_array : Array[String]

var level_modifier : Curse
var gameplay_modifier : Curse
var appearence_modifier : Curse
var curse_chooser_hud : Control

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
	var level_scene : PackedScene = load("res://scenes/levels/orignal_level.tscn")
	base_level = level_scene.instantiate()
	
	curse_manager.load_curse(&"curse_of_inversion")
	curse_manager.add_curse_to_player(&"curse_of_inversion")


func _physics_process(delta: float) -> void:
	
	if not paused:
		current_curse.run(delta)

func end_level() -> void:
	progress += 1
	progress_checker()
	current_curse.end()
	curse_chooser_hud.curse_selection()
	player.speed = 0
	player.jump_height = 0

func progress_checker() -> void:
	
	if progress > curse_id_array.size():
		current_level.scale = Vector2(1,1)
		
	elif progress > curse_id_array.size() * 2:
		current_level.scale = Vector2(1,-1)
		curse_left_id_array = curse_id_array
		
	elif progress > curse_id_array.size() * 3:
		current_level.scale = Vector2(-1,1)
		curse_left_id_array = curse_id_array
		
	elif progress > curse_id_array.size() * 4:
		current_level.scale = Vector2(-1,-1)
		curse_left_id_array = curse_id_array
		
func start_level() -> void:
	

	current_curse._ready()
	
	if current_curse.tags.has(Curse.TARGETS.LEVEL_SCENE):
		
		level_modifier = current_curse
		current_level.visible = false
		var new_level : Level
		
		if current_curse.level_scene != null:
			new_level = current_curse.level_scene.instantiate()
		elif current_curse.level_node != null:
			new_level = current_curse.level_node
		
		new_level.set_checkpoint()
		active_checkpoint = current_level.checkpoint
		
	else:
		current_level.visible = true
		level_modifier = null
		var original_level_scene : PackedScene = load("res://scenes/levels/orignal_level.tscn")
		current_level = original_level_scene.instantiate()
		for child in level_parent.get_children():
			if child is Level:
				child.queue_free()
		
		current_level.set_checkpoint()
		level_parent.add_child(current_level)
	
	if current_curse.tags.has(Curse.TARGETS.PLAYER_APPEARENCE):
		appearence_modifier = current_curse
	
	if current_curse.tags.has(Curse.TARGETS.PLAYER_MOUVEMENT_MODIFIER) or current_curse.tags.has(Curse.TARGETS.PLAYER_MOUVEMENT_OVERHAUL):
		gameplay_modifier = current_curse

	current_level.label.text = str(progress)
	start_round()
	current_curse.start()


func start_round() -> void:
	Game.player.hurtbox.health = Game.player.hurtbox.max_health
	Game.player.position = Game.active_checkpoint.position
	player.speed = player.default_speed
	player.jump_height = player.default_jump_height
