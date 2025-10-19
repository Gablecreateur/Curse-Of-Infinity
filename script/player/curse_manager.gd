extends Node
class_name CurseManager

signal finished_loading

var curse_scene_path_dict : Dictionary[StringName,NodePath] = {
	no_curse = "res://scenes/curses/no_curse.tscn"
}

var loaded_curse_dict : Dictionary[StringName,Curse]

func _ready() -> void:
	load_curse(&"no_curse")
	
	finished_loading.emit()


func load_curse(id : StringName) -> void:
	
	var packed_scene : PackedScene = load(curse_scene_path_dict[id])
	var instance : Curse = packed_scene.instantiate()
	self.add_child(instance)
	loaded_curse_dict[id] = instance
	Game.total_curse_dict = loaded_curse_dict
