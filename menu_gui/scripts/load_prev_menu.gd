"""
load_prev menu is the menu screen, appears after start menu->load prev pressed
contains: buttons with the prev. saved projects' names 
"""

extends Node2D

#outer container
var Center = preload("res://menu_gui/scripts/center_container.gd")
var center_container = Center.new()


var Grid = preload("res://menu_gui/scripts/base_grid.gd")
var outer_grid = Grid.new()
var planetsOuter_grid = Grid.new()
var left_grid = Grid.new()
var inner_grid = Grid.new()


#to hold the prompts for the user
var Mbox = preload("res://menu_gui/scripts/message_box.gd")
var message_box = Mbox.new()


#controls in the scene
var edit_buttons = ["DELETE PROJECT", "Save Changes","Load Project"]
var start_buttons = ["projects","Play New Game","Exit Game"]
var tableName

func _ready():
	
	message_box.get_mbox_ready("Edit or Delete Data")
	center_container.set_sizeTo_screen(1)
	
	#add children containers in order
	self.map_layout()
	
	#the outer grid that holds 2 inner grids
	outer_grid.set_up(2, 30,20)
	
	#projects option grid
	self.prepare_leftGrid()
	
	self.connect_loadPrev_signals()
	Global.get_button_controls(edit_buttons)
	self.connect_edit_signals()
	
	
	pass
	
func map_layout():
	
	#vBox_right.add_child(message_box)
	outer_grid.add_child(left_grid)
	outer_grid.add_child(planetsOuter_grid)

	center_container.add_child(outer_grid)
	self.add_child(center_container)
	
	pass

#TODO: the scroll if the number/size of the buttons exceeds the screen
func connect_loadPrev_signals():
	
	Global.controls_dict["projects"].connect("item_selected", self, "project_pressed");
	Global.controls_dict["Exit Game"].connect("pressed", self,"exit_pressed");
	Global.controls_dict["Play New Game"].connect("pressed", self,"play_pressed");
	pass
	
func connect_edit_signals():
	
	Global.controls_dict["DELETE PROJECT"].connect("pressed", self, "project_delete_pressed");
	Global.controls_dict["Save Changes"].connect("pressed", self, "project_update_pressed");
	Global.controls_dict["Load Project"].connect("pressed", self, "project_load_pressed");
	
	pass
	
func project_pressed(which):
	print(which)
	
	tableName = Global.controls_dict["projects"].get_item_text(which)
	if !Global.was_project_deleted(tableName):
		self.prepare_planetsOuterGrid(tableName)
	else:
		var error = "Project was already deleted!!"
	
	pass

func play_pressed():
	
	Global.set_scene("res://menu_gui/NBodyScene.tscn")
	pass

func exit_pressed():
	
	print("deleted from grid")
	for i in range(0,left_grid.get_child_count()):
		print(left_grid.get_child(i))
		left_grid.get_child(i).queue_free()
		
	message_box.message_label.queue_free()
	left_grid.queue_free()		
			
	Global.exit_game()
	self.get_tree().quit()
	pass
	
func prepare_leftGrid():
	
	left_grid.set_up(1,30,40)
	
	Global.get_button_controls(["Play New Game","Exit Game"])
	
	var prompt = "Choose a Project to Load or Edit:"
	Global.get_option_control("projects", prompt, Global.projects_saved)
	
	left_grid.add_to_grid(start_buttons)

	pass
	
	
func prepare_planetsOuterGrid(tableName):
	
	if planetsOuter_grid.get_child_count() != 0:
		inner_grid.clean_up()
		Global.clean_up_planets()
	else:#the first time
		planetsOuter_grid.set_up(1, 30, 0)
		planetsOuter_grid.add_child(inner_grid)
		planetsOuter_grid.add_to_grid(edit_buttons)
		inner_grid.set_up(Global.data_len,0,5)
		
	var labels_text = ["Name","Mass","Radius", "x ", "y ", "z ", "Vx ", "Vy ", "Vz ", "Orbiting"]
	
	#saves in to the planets_data	
	if Global.load_fromTable("'"+tableName+"'"):
		print("data added form the project")
		
		Global.get_data_labels(labels_text)
		inner_grid.add_to_grid(labels_text)
		
		#creates the lineEdits control and
		#fills with the data from planets_data
		for i in range(Global.planets_data.size()):
			var name = str(i)+"_planet"
			Global.load_lineEdits(i, Global.data_len-1)
			var control = Global.controls_dict[name]
			
			#add the textLines to the inner grid
			for index in range(control.size()):
				inner_grid.add_child(control[index])
	
			
		
		#else:
		#	message_box.update_message("This Project Could not be Loaded", Color(1,0,0));
	
	pass
	
	
func project_delete_pressed():
	
	print("the table name to drop:"+tableName)
	Global.drop_project(tableName)
	
	pass
	
#will need to go to the play scene and add planets	
func project_load_pressed():
	
	#check if changes were made from the text field
	#recheck and save the data
	#load the play scene spawning planets
	
	
	
	pass
	
func project_update_pressed(table_name):
	#get the data from the text fields
	#drop the table 
	#write new data to the table
	
	
	pass


