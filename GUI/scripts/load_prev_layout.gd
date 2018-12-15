"""
class menu_grid is responsble for the layout of the extended
	  grid to accomodate 2 major sections:
		left-
		right-
"""
extends "res://menu_gui/scripts/base_layout.gd"

var right_grid
var left_grid
var center_helper

func _ready():

	pass


#TODO split into several methods
func get_main_ready():

	Global.get_mainControls_ready()

	self.name = "main"

	grid_theme.set_constant("vseparation", "GridContainer", 20)
	grid_theme.set_constant("hseparation", "GridContainer", 30)

	self.columns = 2
	left_grid = GridContainer.new()
	right_grid = GridContainer.new()
	center_helper = CenterContainer.new()

	left_grid.columns = 2
	right_grid.columns = 1

	#set_process(true)

	self.add_to_leftGrid(Global.data_len)
	self.add_to_rightGrid(["play","add", "save" ,"exit"])

	self.add_child(left_grid)
	center_helper.add_child(right_grid)
	self.add_child(center_helper)

	pass

func add_to_leftGrid(value):

	for i in range (value):

		left_grid.add_child(controls_dict[i][0])
		left_grid.add_child(controls_dict[i][1])

	pass

func add_to_rightGrid(listed):

	for item in listed:
		right_grid.add_child(controls_dict[item])

	pass



	
