"""
class menu_grid is responsble for the visual elements of the 
start menu, main menu and ingame widget
"""
#TODO add the design and the automated screen stretch 

extends GridContainer

# class member variables go here, for example:
var grid_theme = Theme.new()

var controls_dict = Global.controls_dict #all the control buttons 
var right_grid
var left_grid
var center_helper


func _ready():
	
	self.set_theme(grid_theme)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
func get_start_ready(all):
	
	self.columns = 1
	Global.get_startButtons_ready(all)
	self.name = "start"
	
	grid_theme.set_constant("vseparation", "GridContainer", 50)
	
	#if there are saved games
	if all:
		self.add_to_grid(["prev_game"])
	#if there are no saved games
	self.add_to_grid(["new_game","exit"])
	
	pass
		
func remove_from_grid(list):
	
	for child in list:
		if controls_dict.has(child):
			self.remove_child(controls_dict[child])
	
	pass
	
func add_to_grid(b_list):
	
	for item in b_list:
		self.add_child(controls_dict[item])
		
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
	
func get_inGame_widget():
	
	self.set_columns(2)
	"""
	controls_dict["popUp"] = MenuButton.new()
	
	controls_dict["add"] = button_template.new()
	controls_dict["add"].add_child(controls_dict["popUp"])
	controls_dict["add"].text = "Add Planet"
	#popUp.set_size(Vector2(80,20))
	controls_dict["add"].set_position(Vector2(20,20))
	
	
	
	controls_dict["save"] = button_template.new()
	controls_dict["save"].text = "Save Game"
	controls_dict["save"].set_position(Vector2(190,20))
	
	
	
	
	controls_dict["exit"] = button_template.new()
	controls_dict["exit"].text = "Exit Game"
	controls_dict["exit"].set_position(Vector2(370,20))
	
	#self.add_to_grid(["add", "save"])
	"""
	
	pass
	
"""	
func planets_data_widget():
	
	
	left_grid = GridContainer.new()
	right_grid = GridContainer.new()
	center_helper = CenterContainer.new()
	
	var grid_theme_temp = Theme.new()
	left_grid.set_theme(grid_theme_temp)
	
	grid_theme_temp.set_constant("vseparation", "GridContainer", 5)
	grid_theme_temp.set_constant("hseparation", "GridContainer", 5)
	left_grid.columns = 2
	right_grid.columns = 1
	
	controls_dict["addPopUp"] = button_template.new()
	controls_dict["addPopUp"].text = "Add "
	
	for index in range(7):
		
		controls_dict[index] = [Label.new(), LineEdit.new()]
	
	var labels_text = ["Enter Mass", "Enter x ", "Enter y ", "Enter z ", "Enter Vx ", "Enter Vy ", "Enter Vz "]
	
	for i in range (labels_text.size()):
		controls_dict[i][0].text = labels_text[i]
		controls_dict[i][1].editable = true
		controls_dict[i][1].expand_to_text_length = true
		controls_dict[i][1].max_length = 5
		
	self.add_to_leftGrid(labels_text.size()) 
	self.add_to_rightGrid(["addPopUp"])
	
	self.add_child(left_grid)
	center_helper.add_child(right_grid)
	self.add_child(center_helper)
	
		
	pass
"""
	
func _process(delta):
	
	#set_size(Vector2 (100, 50))
	#if !text_array.empty() :
		#text_array[0].set_size(Vector2(300, 300))
		#text_array[0].set_scale (Vector2(1.5, 1.5))
	
	pass
	
func get_orbitMenu_grid():
	
	Global.get_orbitControls_ready()
	
	self.name = "orbitGrid"
	
	grid_theme.set_constant("vseparation", "GridContainer", 20)
	grid_theme.set_constant("hseparation", "GridContainer", 30)
	
	self.columns = 2
	

	left_grid = GridContainer.new()
	right_grid = GridContainer.new()
	center_helper = CenterContainer.new()
	
	left_grid.columns = 2
	right_grid.columns = 1
			
	#set_process(true)
	#add to grid
	for i in range(Global.planets_data.size()):
		var name = "index_"+str(i)
		left_grid.add_child(Global.controls_dict[name][0])
		left_grid.add_child(Global.controls_dict[name][1])
	
	self.add_to_leftGrid(Global.data_len) 
	self.add_to_rightGrid(["simulate","exit"])
	
	self.add_child(left_grid)
	center_helper.add_child(right_grid)
	self.add_child(center_helper)
	
	pass