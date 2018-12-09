"""
start menu is the first screen in the simulation
contains: load previous games if exit
		  exit the game
		  play the game
"""

extends Node2D

#var center_container = CenterContainer.new()
var Grid = preload("res://menu_gui/scripts/base_grid.gd")
var grid = Grid.new()
var Center = preload("res://menu_gui/scripts/center_container.gd")
var center_container = Center.new()
var use_all
var buttons_list = []

func _ready():
	
	use_all = Global.has_saved_games()
	self.get_grid_ready(use_all)
	self.connect_start_signals(use_all)
	
	center_container.add_child(grid)
	center_container.set_sizeTo_screen(1)
	self.add_child(center_container)
	
	pass

func get_grid_ready(all):
	
	grid.set_up(1,50,0)

	if all:
		buttons_list.append("Load Previous Game")
		
	buttons_list += ["Play New Game","Exit Game"]
	Global.get_button_controls(buttons_list)
	
	grid.add_to_grid(buttons_list)
	
	pass

func connect_start_signals(all):
	
	Global.controls_dict["Exit Game"].connect("pressed", self, "exit_pressed")
	Global.controls_dict["Play New Game"].connect("pressed", self, "play_pressed")
	
	if all:
		Global.controls_dict["Load Previous Game"].connect("pressed", self, "prevGame_pressed")
		
	pass
	
func play_pressed():
	
	Global.set_scene("res://menu_gui/NBodyScene.tscn")
	pass

func exit_pressed():
	
	print("deleted from grid in start menu")
	for i in range(0,grid.get_child_count()):
		print(grid.get_child(i))
		grid.get_child(i).queue_free()
		
	grid.queue_free()	
			
	Global.exit_game()
	self.get_tree().quit()
	pass
	
func prevGame_pressed():
	
	print("prevGame pressed")
	Global.set_scene("res://menu_gui/load_prev_scene.tscn");
	
	pass
