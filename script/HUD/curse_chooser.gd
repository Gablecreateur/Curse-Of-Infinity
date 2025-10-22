extends Control

var curse_option : int = 3
var chosen_curses_array : Array[Curse]

@onready var button_parent : Control = $VBoxContainer


func curse_selection() -> void:
	self.visible = true
	
	for i in curse_option:
		#var tested_curse : Curse
		var chosen_curse_id : String = Game.curse_id_array[randi_range(0,Game.curse_id_array.size()-1)]
		print(chosen_curse_id)
		
		var button : Button = Button.new()
		button.text = chosen_curse_id
		button.theme = load("res://assets/themes/main_theme.tres")
		button_parent.add_child(button)
		
		

func _ready() -> void:
	Game.curse_chooser_hud = self
