"""
class menu_grid is responsble for the layout of the extended
	  grid to accomodate 2 major sections:
		left-
		right-
"""

extends "res://GUI/scripts/base_layout.gd"


var Grid = preload("res://GUI/scripts/base_layout.gd")

var buttons_grid = Grid.new()
var data_grid = Grid.new()
var center_helper= CenterContainer.new()
var orbit_grid = Grid.new()
var labels_quant = Global.planets_params
var planets_names = []

signal orbit_defined(name, planet_index)


func _ready():
	
	

	pass
	
#TODO split into several methods
func get_main_ready(buttons_list, labels_list):
	
	print(buttons_list)
	print(labels_list)

	controls.get_button_controls(buttons_list)
	controls.get_parallelControls_ready(labels_list)

	print(controls.controls_dict)
	
	self.set_up(2,5,5)
	
	data_grid.columns = 2
	buttons_grid.columns = 1
	orbit_grid.set_up(1,5,5)

	#no orbiting is added here
	data_grid.add_parallelControls(labels_list,controls_dict)
	print(controls.controls_dict)
	buttons_grid.add_to_grid(buttons_list, controls_dict)

	self.add_child(data_grid)
	
	center_helper.add_child(buttons_grid)
	self.add_child(center_helper)
	#self.add_child(orbit_grid)

	pass


func add_orbits(planet_index):
	
	var prompt
	var name
	
	
	if planet_index == 0:
		name = str(Global.planets_data[0][0])
		prompt = "Choose planet for "+ str(name) + " to orbit"
		controls.get_option_control(name, prompt,["NO Orbiting"])
		planets_names.append("NO Orbiting")
	
	else:
		name = str(Global.planets_data[planet_index][0])
		prompt = "Choose planet for "+ str(name) + " to orbit"
		print(planets_names)
		controls.get_option_control(name, prompt,planets_names)
		
		#all names but not for No Orbiting
		for i in range(1,planets_names.size()):
			controls.controls_dict[planets_names[i]].add_item(name)
	
	print("name of the planet: " + name)	
	orbit_grid.add_child(controls.controls_dict[name])
	emit_signal("orbit_defined", name, planet_index)
			
	planets_names.append(name)

	pass
