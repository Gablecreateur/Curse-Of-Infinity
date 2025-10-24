extends Node
class_name CurseManager

signal finished_loading

var curse_scene_path_dict : Dictionary[StringName,NodePath] = {
	no_curse = "res://scenes/curses/no_curse.tscn",
	curse_of_speed = "res://scenes/curses/curse_of_speed.tscn",
	#curse_of_mass = "res://scenes/curses/curse_of_mass.tscn",
	curse_of_diving = "res://scenes/curses/curse_of_diving.tscn",
	curse_of_the_feather = "res://scenes/curses/curse_of_the_feather.tscn",
	curse_of_the_mouse = "res://scenes/curses/curse_of_the_mouse.tscn",
	curse_of_titan = "res://scenes/curses/curse_of_titan.tscn",
	curse_of_inversion = "res://scenes/curses/curse_of_inversion.tscn",
	curse_of_the_bishop = "res://scenes/curses/curse_of_the_bishop.tscn",
	curse_of_tripping = "res://scenes/curses/curse_of_tripping.tscn",
	curse_of_akinotepsia = "res://scenes/curses/curse_of_akinotepsia.tscn",
	curse_of_zoom = "res://scenes/curses/curse_of_zoom.tscn"
}

var curse_id_array : Array[String]

var loaded_curse_dict : Dictionary[StringName,Curse]

var player_overhaul_curse : Curse = null

func _ready() -> void:
	populate_id_array()
	load_curse(&"no_curse")

	finished_loading.emit()

func populate_id_array() -> void:
	
	for key in curse_scene_path_dict:
		if not curse_id_array.has(key):
			curse_id_array.append(key)
			
	
	Game.curse_id_array = curse_id_array
	Game.curse_left_id_array = curse_id_array

func load_curse(curse_id : StringName) -> void:
	
	var packed_scene : PackedScene = load(curse_scene_path_dict[curse_id])
	var instance : Curse = packed_scene.instantiate()
	self.call_deferred("add_child",instance)
	loaded_curse_dict[curse_id] = instance
	Game.total_curse_dict = loaded_curse_dict

func add_curse_to_player(curse_id : StringName) -> void:
	
	if loaded_curse_dict[curse_id] == null:
		print(curse_id + "curse not loaded")
	
	else:
		var curse : Curse = loaded_curse_dict[curse_id]
		Game.current_curse = curse
