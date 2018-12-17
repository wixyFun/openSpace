"""
load_prev menu is the menu screen, appears after start menu->load prev pressed
contains: buttons with the prev. saved projects' names 
"""
 

extends Node2D


var Grid = preload("res://GUI/scripts/base_layout.gd")
var outer_grid = Grid.new()
var planetsOuter_grid = Grid.new()
var left_grid = Grid.new()
var inner_grid = Grid.new()

var center_container = outer_grid.center_container
var message_box = outer_grid.message_box
var controls_dict = outer_grid.controls.controls_dict



#controls in the scene
var edit_buttons = ["DELETE PROJECT","Load Project"]
var start_buttons = ["projects","Play New Game","Exit Game"]
var tableName

func _ready():
	
	Global.set_prev_scene(Global.load_prev_scene)
	
	message_box.get_mbox_ready("Edit or Delete Data")
	center_container.set_sizeTo_screen(1)
	outer_grid.scroll_container.rect_min_size = OS.window_size
	Global.connect("update_message", self, "update_message")
	
	#add children containers in order
	self.map_layout()
	
	#the outer grid that holds 2 inner grids
	outer_grid.set_up(2, 30,20)
	
	#projects option grid
	self.prepare_leftGrid()
	
	self.connect_loadPrev_signals()
	outer_grid.controls.get_button_controls(edit_buttons)
	self.connect_edit_signals()
	
	
	pass
	
func map_layout():
	
	#vBox_right.add_child(message_box)
	outer_grid.add_child(left_grid)
	outer_grid.add_child(planetsOuter_grid)
	
	center_container.add_child(outer_grid)
	outer_grid.scroll_container.add_child(center_container)
	self.add_child(outer_grid.scroll_container)
	
	pass

#TODO: the scroll if the number/size of the buttons exceeds the screen
func connect_loadPrev_signals():
	
	controls_dict["projects"].connect("item_selected", self, "project_pressed");
	controls_dict["Exit Game"].connect("pressed", self,"exit_pressed");
	controls_dict["Play New Game"].connect("pressed", self,"play_pressed");
	pass
	
func connect_edit_signals():
	
	controls_dict["DELETE PROJECT"].connect("pressed", self, "project_delete_pressed");
	#controls_dict["Save Changes"].connect("pressed", self, "project_update_pressed");
	controls_dict["Load Project"].connect("pressed", self, "project_load_pressed");
	
	pass
	
func project_pressed(which):
	
	tableName = controls_dict["projects"].get_item_text(which)
	update_message("Edit or Delete Project "+str(tableName),Color(1,0,0))
	if !Global.was_project_deleted(tableName):
		Global.current_table = tableName
		self.prepare_planetsOuterGrid(tableName)
	else:
		update_message("Project " +str(tableName)+" was already deleted",Color(1,0,0))
		inner_grid.clean_up()
	pass

func play_pressed():
	
	Global.set_scene(Global.play_scene)
	pass

func exit_pressed():
	

	
	for i in range(0,left_grid.get_child_count()):
		left_grid.get_child(i).queue_free()
		
	message_box.message_label.queue_free()
	left_grid.queue_free()		
			
	Global.exit_game()
	self.get_tree().quit()
	pass
	
func prepare_leftGrid():
	
	left_grid.set_up(1,30,40)
	
	outer_grid.controls.get_button_controls(["Play New Game","Exit Game"])
	
	var prompt = "Choose a Project to Load or Edit:"
	outer_grid.controls.get_option_control("projects", prompt, Global.projects_saved)
	
	left_grid.add_to_grid(start_buttons, controls_dict)

	pass
	
	
func prepare_planetsOuterGrid(tableName):
	
	if planetsOuter_grid.get_child_count() != 0:
		inner_grid.clean_up()
		Global.clean_up_planets()
	else:#the first time
		planetsOuter_grid.set_up(1, 30, 0)
		planetsOuter_grid.add_child(message_box)
		planetsOuter_grid.add_child(inner_grid)
		planetsOuter_grid.add_to_grid(edit_buttons, controls_dict)
		inner_grid.set_up(Global.planets_params,0,5)
		
	var labels_text = ["Name\n(any value)","Mass\n(positive)","Radius\n(positive)", "x\n(numeric) ", "y\n(numeric) ", "z\n(numeric)", "Vx\n(numeric)", "Vy\n(numeric)", "Vz\n(numeric)", "Orbiting\n(only id)"]
	
	#saves in to the planets_data	
	if Global.load_planets_data(tableName):
		
		outer_grid.controls.get_data_labels(labels_text)
		inner_grid.add_to_grid(labels_text,controls_dict)
	
		
		#creates the lineEdits control and
		#fills with the data from planets_data
		for i in range(Global.planets_data.size()):
			var name = str(i)+"_planet"
			outer_grid.controls.load_lineEdits(i, Global.planets_params,Global.planets_data)
			var control = controls_dict[name]
			
			#add the textLines to the inner grid
			for index in range(control.size()):
				inner_grid.add_child(control[index])
	else:
		update_message("Project " + str(tableName)+" Could not be Loaded", Color(1,0,0));
	
	pass
	
	
func project_delete_pressed():
	
	var index = outer_grid.controls.controls_dict["projects"].get_selected_id()
	print(index)
	
	if Global.drop_projects(tableName):
		print("projectssss")
		outer_grid.controls.controls_dict["projects"].remove_item(index)
		update()
	
	
	
	pass
	
#will need to go to the play scene and add planets	
func project_load_pressed():
	
	if Global.planets_data.size() == 0:
		update_message("Cannot Load without Data!!! Project was deleted!", Color(1,0,0))
	else:
		Global.set_scene(Global.play_scene)
	
	pass
	
func project_update_pressed():
	#get the data from the text fields
	
	var prev_data = Global.planets_data.duplicate()
	Global.clean_up_planets()
	
	var valueArray
	
	#get all the values from the labels
	for planet_key in range(prev_data.size()):
		var name = str(planet_key)+"_planet"
		valueArray = []
		for label in range(controls_dict[name].size()):
			valueArray.append(controls_dict[name][label].text)
			
		emit_signal("add_data",valueArray)
	
	#drop the table 
	
	if Global.drop_projects(Global.current_table):
		#write new data to the table
		emit_signal("save_data")
	
	pass

func update_message(text, color):
	
	message_box.update_message(text,color)
	
	pass

