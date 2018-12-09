"""
class menu_grid is responsble for the layout of the extended
	  grid to accomodate 2 major sections:
		left-
		right-
"""

extends "res://menu_gui/scripts/base_grid.gd"

var buttons_grid
var data_grid
var center_helper
var orbit_grid
var planets_names = []


var Grid = preload("res://menu_gui/scripts/base_grid.gd")

func _ready():
	
	data_grid = Grid.new()
	buttons_grid = Grid.new()
	orbit_grid = Grid.new()
	center_helper = CenterContainer.new()

	pass
	
#TODO split into several methods
func get_main_ready(buttons_list, labels_list):

	Global.get_button_controls(buttons_list)
	Global.get_parallelControls_ready(labels_list)

	self.set_up(2,5,5)
	
	data_grid.columns = 2
	buttons_grid.columns = 1
	orbit_grid.set_up(1,5,5)

	data_grid.add_parallelControls(Global.data_len)
	buttons_grid.add_to_grid(buttons_list)

	self.add_child(data_grid)
	
	center_helper.add_child(buttons_grid)
	self.add_child(center_helper)
	#self.add_child(orbit_grid)

	pass

func _process(delta):

	#set_size(Vector2 (100, 50))
	#if !text_array.empty() :
		#text_array[0].set_size(Vector2(300, 300))
		#text_array[0].set_scale (Vector2(1.5, 1.5))

	pass

func add_orbits(number):
	
	
	var prompt
	var name
	
	if planets_names.empty():
		name = str(Global.planets_data[0][0])
		prompt = "Choose planet for "+ str(name) + "to orbit"
		Global.get_option_control(name, prompt,["NONE"])
	
	else:
		name = str(Global.planets_data[number-1][0])
		prompt = "Choose planet for "+ str(name) + "to orbit"
		Global.get_option_control(name, prompt,planets_names)
		Global.controls_dict[name].add_item("NONE")
		for planet_button in planets_names:
			Global.controls_dict[planet_button].add_item(name)
		
	orbit_grid.add_child(Global.controls_dict[name])
			
	planets_names.append(name)

	pass
