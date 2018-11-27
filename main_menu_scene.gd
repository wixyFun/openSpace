"""
Class main_menu_scene is responsible for the start and main menus'
functionality/buttons response
"""
#TODO: automatical resizing depending on the os window size

extends Node2D

# class member variables go here, for example:
var center_container
var grid = preload("res://menu_grid.gd").new()
var message_box
var message_label


func _ready():
	
	self.get_message_ready()
	
	message_box.add_child(message_label)
	self.add_child(message_box)
	self.get_main_menu_ready()
	
	center_container.add_child(grid)
	add_child(center_container)
	
	pass
	
func get_message_ready():
	
	message_box = CenterContainer.new()
	message_label = Label.new()
	
	
	message_box.use_top_left = true
	message_box.set_margin(MARGIN_TOP, 30)
	message_box.set_margin( MARGIN_LEFT, 170)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_container_ready():
	
	center_container = CenterContainer.new()
	center_container.use_top_left = true
	#center_container.set_margin( MARGIN_BOTTOM, 200)
	center_container.set_margin( MARGIN_RIGHT, 200)
	center_container.set_margin(MARGIN_TOP, 250)
	center_container.set_margin(MARGIN_LEFT, 200)
	
	
	
	pass
		
func get_main_menu_ready():
	
	# Called when the node is added to the scene for the first time.
	get_container_ready()
	grid.get_start_ready()
	self.set_start_controls()
	
	
	
	pass
	
func set_start_controls():
	
	grid.controls_dict["exit"].connect("pressed", self, "exit_pressed")
	grid.controls_dict["new_game"].connect("pressed", self, "set_data_collection")
	
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
	
	if !(value.is_valid_float()):
		
		self.update_message("You Have Entered Wrong Value for ' " + label + "' \nPlease Re-enter the value !!!", Color(1,0,0))
		return false
	else:
		if label == str(grid.controls_dict[0][0].text):
			if value.to_float() <=0:
				self.update_message("Mass Cannot Be Negative or Equal to Zero", Color(1,0,0))
				return false
			
			
	self.update_message("Enter Numeric Values Only", Color(0,0,0))
	
	return true
	
func play_pressed():
	
	#TODO insert assertion that there are planets to render befor allowing to play
	Global.set_scene("res://NBodyDemo.tscn")
	#Global.set_scene("res://play_scene.tscn")
	
	pass
#TODO add duplicate entries validation  for the coordinates !!!!!!!!!!!!	
func add_pressed():
	
	var planet_num = Global.planets_data.size() 

	var valueArray = []
	var temp
	var change = true
	
	for i in range(7):
		temp = grid.controls_dict[i][1].text
		
		
		if !self.validate(temp, str(grid.controls_dict[i][0].text)): 
			change = false
		
	if !change:
		self.update_message("Cannot Add Given Values, Please Reenter", Color(1,0,0))
	else:
		for i in range(7):
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
	
func set_data_collection():
	
	grid.remove_from_grid(["exit","prev_game","new_game"])
	grid.get_main_ready()
	self.set_main_controls()
	message_label.text = "Please Enter Numeric Values"
	
	
	
	pass
	
func exit_pressed():
	
	Global.exit_game()
	self.get_tree().quit()
	
	
	
	pass