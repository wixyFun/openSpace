"""
start menu is the first screen in the simulation
contains: load previous games if exit
		  exit the game
		  play the game
"""

extends Node2D

#var center_container = CenterContainer.new()
var Grid = preload("res://GUI/scripts/base_layout.gd")
var layout = Grid.new()

var use_all
var buttons_list = ["Play New Game","Exit" ]

func _ready():
	
	use_all = Global.load_saved_projects()
	self.get_grid_ready(use_all)
	self.connect_start_signals(use_all)
	
	layout.center_container.add_child(layout)
	layout.center_container.set_sizeTo_screen(1)
	self.add_child(layout.center_container)
	
	pass

func get_grid_ready(all):
	
	layout.set_up(1,50,0)

	if all:
		buttons_list.push_front("Load Previous Game")
		
	layout.controls.get_button_controls(buttons_list)
	
	layout.add_to_grid(buttons_list,layout.controls.controls_dict)
	
	pass

func connect_start_signals(all):
	
	layout.controls.controls_dict["Exit"].connect("pressed", self, "exit_pressed")
	layout.controls.controls_dict["Play New Game"].connect("pressed", self, "play_pressed")
	
	if all:
		layout.controls.controls_dict["Load Previous Game"].connect("pressed", self, "prevGame_pressed")
		
	pass
	
func play_pressed():
	
	Global.set_scene(Global.play_scene)
	pass

func exit_pressed():
	
	for i in range(0,layout.get_child_count()):
		
		layout.get_child(i).queue_free()
		
	layout.queue_free()	
			
	Global.exit_game()
	self.get_tree().quit()
	pass
	
func prevGame_pressed():
	
	Global.set_scene(Global.load_prev_scene);
	
	pass
