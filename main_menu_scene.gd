"""
Class main_menu_scene is responsible for the start and main menus'
functionality/buttons response
"""
#TODO: automatical resizing depending on the os window size

extends Node2D

# class member variables go here, for example:
var center_container = CenterContainer.new()
var Grid = preload("res://menu_grid.gd")
var grid = Grid.new()
var message_box = CenterContainer.new()
var message_label = Label.new()


func _ready():
	
	self.get_message_ready()
	
	message_box.add_child(message_label)
	self.add_child(message_box)
	self.get_start_menu_ready()
	
	center_container.add_child(grid)
	self.add_child(center_container)
	
	pass
	
func get_message_ready():
	
	message_box.use_top_left = true
	message_box.set_margin(MARGIN_TOP, 30)
	message_box.set_margin( MARGIN_LEFT, 170)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_container_ready():
	
	center_container.use_top_left = true
	#center_container.set_margin( MARGIN_BOTTOM, 200)
	center_container.set_margin( MARGIN_RIGHT, 200)
	center_container.set_margin(MARGIN_TOP, 250)
	center_container.set_margin(MARGIN_LEFT, 200)
	
	
	
	pass

#the 1st menu screen with 2/3 buttons		
func get_start_menu_ready():
	
	# Called when the node is added to the scene for the first time.
	get_container_ready()
	
	#show/not the load previous game button
	if Global.has_saved_games():
		grid.get_start_ready(true)
		self.set_start_controls(true)
	else:
		grid.get_start_ready(false)
		self.set_start_controls(false)
		
	pass
	
func set_start_controls(all):
	
	grid.controls_dict["exit"].connect("pressed", self, "exit_pressed")
	grid.controls_dict["new_game"].connect("pressed", self, "set_data_collection")
	
	if all:
		grid.controls_dict["prev_game"].connect("pressed", self, "prevGame_pressed")
		
	pass
	
func set_main_controls():
	
	grid.controls_dict["play"].connect("pressed", self, "play_pressed")
	grid.controls_dict["add"].connect("pressed", self, "add_pressed")
	
	grid.controls_dict[0][1].connect("text_changed", self, "validate_mass")
	grid.controls_dict[1][1].connect("text_changed", self, "validate_x")
	grid.controls_dict[2][1].connect("text_changed", self, "validate_y")
	grid.controls_dict[3][1].connect("text_changed", self, "validate_z")
	grid.controls_dict[4][1].connect("text_changed", self, "validate_Vx")
	grid.controls_dict[5][1].connect("text_changed", self, "validate_Vy")
	grid.controls_dict[6][1].connect("text_changed", self, "validate_Vz")
	
		
	
	pass
	
func validate_mass(new_text):
	
	self.validate(new_text,str(grid.controls_dict[0][0].text))
	
	pass
	
func validate_x(new_text):
	
	self.validate(new_text,str(grid.controls_dict[1][0].text))
	pass
	
func validate_y(new_text):
	
	self.validate(new_text,str(grid.controls_dict[2][0].text))
	pass
	
func validate_Vx(new_text):
	
	self.validate( new_text,str(grid.controls_dict[4][0].text))
	pass
	
func validate_Vy(new_text):
	
	self.validate(new_text,str(grid.controls_dict[5][0].text))
	pass
	
func validate_Vz(new_text):
	
	self.validate(new_text,str(grid.controls_dict[6][0].text))
	pass
	
func validate_z(new_text):
	
	self.validate(new_text,str(grid.controls_dict[3][0].text))
	pass
	
func validate(value, label):
	
	#not an integer or a float checked
	if !(value.is_valid_float()):
		self.update_message("You Have Entered Wrong Value for ' " + label + "' \nPlease Re-enter the value !!!", Color(1,0,0))
		return false
	else:
		if label == str(grid.controls_dict[0][0].text):#mass
			if value.to_float() <=0:
				self.update_message("Mass Cannot Be Negative or Equal to Zero", Color(1,0,0))
				return false
	#all is good-resent to empty message 					
	self.update_message("", Color(0,0,0))
	
	return true
	
func play_pressed():
	
	#check if there are planets to simulate
	if Global.planets_data.size() == 0 :
		self.update_message("Enter Data for Planet/s First", Color(1,0,0))
	else:
		#Global.set_scene("res://NBodyDemo.tscn")
		Global.set_scene("res://play_scene.tscn")
	
	pass
	
#TODO add duplicate entries validation  for the coordinates !!!!!!!!!!!!	
func add_pressed():
	
	var planet_num = Global.planets_data.size() 

	var valueArray = []
	var temp
	var change = true
	
	#get the text from the lineEdits in the menu
	#re-validate
	for i in range(7):
		temp = grid.controls_dict[i][1].text
		
		if !self.validate(temp, str(grid.controls_dict[i][0].text)): 
			change = false
		
	if !change:
		self.update_message("Cannot Add Given Values, Please Reenter", Color(1,0,0))
	else:
		for i in range(Global.data_len):
			temp = grid.controls_dict[i][1].text.to_float()
			valueArray.append(temp)
		Global.planets_data[planet_num] = valueArray
		self.update_message("Added Another Planet. So Far There are: " + str(planet_num + 1) + " planets", Color(2,2,2))
	
	print(Global.planets_data)		

	pass
	
func update_message(prompt, colored):
	message_label.text = prompt
	message_label.add_color_override("font_color", colored)
	message_label.ALIGN_RIGHT
	message_label.update()
	pass

#after the new game nutton pressed	
func set_data_collection():
	
	grid.remove_from_grid(["exit", "new_game", "prev_game"])
	grid.get_main_ready()
	self.set_main_controls()
	message_label.text = "Please Enter Numeric Values"
	
	pass
	
func exit_pressed():
	
	print("deleted from grid")
	for i in range(0,grid.get_child_count()):
		print(grid.get_child(i))
		grid.get_child(i).queue_free()
		
	message_label.queue_free()	
	grid.queue_free()		
	
	match grid.name:
		"start":
			#f
			print("start")
			
			continue
		"main":
			print("main")
			Global.controls_dict["new_game"].queue_free()
			if Global.controls_dict.has("prev_game"):
				Global.controls_dict["prev_game"].queue_free()
				
	
			continue
		
	
			
	Global.exit_game()
	self.get_tree().quit()
	pass