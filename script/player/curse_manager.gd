extends Node
class_name CurseManager

signal finished_loading

var curse_scene_path_dict : Dictionary[StringName,NodePath] = {
	no_curse = "res://scenes/curses/no_curse.tscn",
	curse_of_speed = "res://scenes/curses/curse_of_speed.tscn",
	curse_of_mass = "res://scenes/curses/curse_of_mass.tscn"
}

var loaded_curse_dict : Dictionary[StringName,Curse]

var player_overhaul_curse : Curse = null

func _ready() -> void:
	load_curse(&"no_curse")

	finished_loading.emit()


func load_curse(curse_id : StringName) -> void:
	
	var packed_scene : PackedScene = load(curse_scene_path_dict[curse_id])
	var instance : Curse = packed_scene.instantiate()
	self.add_child(instance)
	loaded_curse_dict[curse_id] = instance
	Game.total_curse_dict = loaded_curse_dict

func add_curse_to_player(curse_id : StringName) -> void:
	
	if loaded_curse_dict[curse_id] == null:
		print(curse_id + "curse not loaded")
	
	else:
		var curse : Curse = loaded_curse_dict[curse_id]
		if not Game.active_curse_array.has(curse):
			Game.active_curse_array.append(curse)
			curse.start()
