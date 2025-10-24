extends Control

var curse_option_nmb : int = 3
var chosen_curses_array : Array[Curse]

var button_curse_dict : Dictionary[Button,Curse] = {}

@onready var button_parent : Control = $VBoxContainer


func curse_selection() -> void:
	if not Game.paused:
		self.visible = true
		Game.paused = true
		
		
		for i in curse_option_nmb:
			var chosen_curse_id : String = Game.curse_left_id_array[randi_range(0,Game.curse_id_array.size()-1)]
			Game.curse_manager.load_curse(chosen_curse_id)
			var curse : Curse = Game.curse_manager.loaded_curse_dict[chosen_curse_id]
			
			var button : Button = Button.new()
			button.text = curse.curse_name
			button.scale = Vector2(5,5)
			button.theme = load("res://assets/themes/main_theme.tres")
			button_parent.add_child(button)
			button.pressed.connect(button_pressed.bind(button))
			button_curse_dict[button] = curse


func _ready() -> void:
	Game.curse_chooser_hud = self

func button_pressed(button : Button) -> void:
	Game.paused = false
	Game.curse_manager.add_curse_to_player(button_curse_dict[button].id)
	Game.curse_left_id_array.erase(button_curse_dict[button].id)
	button_curse_dict = {}
	for child in button_parent.get_children():
		child.queue_free()
	Game.start_level()
	self.visible = false
