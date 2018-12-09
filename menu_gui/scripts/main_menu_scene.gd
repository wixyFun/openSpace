"""
Class main_menu_scene is responsible for the start and main menus'
functionality/buttons response
"""
#TODO: automatical resizing depending on the os window size

extends Node2D

# class member variables go here, for example:
var Center = preload("res://menu_gui/scripts/center_container.gd")
var center_container = Center.new()
var Grid = preload("res://menu_gui/scripts/menu_grid.gd")
var grid = Grid.new()
var Mbox = preload("res://menu_gui/scripts/message_box.gd")
var message_box = Mbox.new()
var already_saved
var added_again

var outer_center = CenterContainer.new()
var hBox = HBoxContainer.new()
var vBox = VBoxContainer.new()

var data_labels
var buttons_list


func _ready():
	
	message_box.get_mbox_ready("Enter Numeric Data Only.")
	#message_box.set_frame(50,0,0,0)#top bottom right left
	vBox.set_margin(MARGIN_TOP, 20)
	
	already_saved = false
	added_again = 0
	self.map_layout()
	center_container.set_frame(1,1,1,0)
	center_container.set_sizeTo_screen(0.75)
	
	pass
	
func map_layout():
	
	self.add_child(vBox)
	vBox.add_child(message_box)
	vBox.add_child(center_container)
	center_container.add_child(hBox)
	hBox.add_child(grid)
	hBox.add_child(grid.orbit_grid)

	pass
	
func set_lists(btn_list, labl_list):
	
	data_labels = labl_list
	buttons_list = btn_list
	
	pass
	
func ready_menu():
	
	grid.get_main_ready(buttons_list,data_labels)
	self.set_main_controls()
	
	pass
	
func set_main_controls():
	
	for butn in buttons_list:
		if butn != "Simulate":
			print("buttons list size")
			print(buttons_list.size())
			Global.controls_dict[butn].connect("pressed", self, str(butn+"_pressed"))

	grid.controls_dict[0][1].connect("text_changed", self, "validate_name")
	grid.controls_dict[1][1].connect("text_changed", self, "validate_mass")
	grid.controls_dict[2][1].connect("text_changed", self, "validate_radius")
	grid.controls_dict[3][1].connect("text_changed", self, "validate_x")
	grid.controls_dict[4][1].connect("text_changed", self, "validate_y")
	grid.controls_dict[5][1].connect("text_changed", self, "validate_z")
	grid.controls_dict[6][1].connect("text_changed", self, "validate_Vx")
	grid.controls_dict[7][1].connect("text_changed", self, "validate_Vy")
	grid.controls_dict[8][1].connect("text_changed", self, "validate_Vz")
	
	pass
	
func validate_mass(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[1][0].text))
	
	pass
	
func validate_name(new_text):
	
	#self.validate_logic(new_text,str(grid.controls_dict[0][0].text))
	
	pass
	
func validate_radius(new_text):
	
	#self.validate_logic(new_text,str(grid.controls_dict[2][0].text))
	
	pass
	
func validate_x(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[3][0].text))
	pass
	
func validate_y(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[4][0].text))
	pass
	
func validate_Vx(new_text):
	
	self.validate_logic( new_text,str(grid.controls_dict[6][0].text))
	pass
	
func validate_Vy(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[7][0].text))
	pass
	
func validate_Vz(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[8][0].text))
	pass
	
func validate_z(new_text):
	
	self.validate_logic(new_text,str(grid.controls_dict[5][0].text))
	pass
	
func validate_logic(value, label):
	
	#not an integer or a float checked
	if !(value.is_valid_float()):
		message_box.update_message("You Have Entered Wrong Value for ' " + label + "' \nPlease Re-enter the value !!!", Color(1,0,0))
		return false
	else:
		if label == str(grid.controls_dict[0][0].text):#mass
			if value.to_float() <=0:
				message_box.update_message("Mass Cannot Be Negative or Equal to Zero", Color(1,0,0))
				return false
	#all is good-resent to empty message 					
	message_box.update_message("", Color(0,0,0))
	
	return true
	
#TODO add duplicate entries validation  for the coordinates !!!!!!!!!!!!	
func Add_pressed():
	
	var planet_num = Global.planets_data.size() 

	var valueArray = []
	var temp
	var change = true
	
	#get the text from the lineEdits in the menu
	#re-validate
	for i in range(Global.data_len):
		temp = grid.controls_dict[i][1].text
		"""TODO:Fix the recheck
		if !self.validate_logic(temp, str(grid.controls_dict[i][0].text)): 
			change = false
		"""
	if !change:
		message_box.update_message("Cannot Add Given Values, Please Reenter", Color(1,0,0))
	else:
		for i in range(Global.data_len):
			temp = grid.controls_dict[i][1].text.to_float()
			valueArray.append(temp)
			
		if !Global.has_duplicates(valueArray):
			Global.planets_data[planet_num] = valueArray
			added_again +=1
			grid.add_orbits(Global.planets_data.size())
			message_box.update_message("Added Another Planet. So Far There are: " + str(planet_num + 1) + " planets", Color(2,2,2))
		else:
			message_box.update_message("Cannot Add Duplicate Coordinates.Re-enter!", Color(1,0,0));	
	print(Global.planets_data)		

	pass

#TODO: add update data if user will press more than once on save button	
func Save_pressed():
	
	if already_saved && added_again == 0:
		message_box.update_message("This Data was Already Saved!", Color(1,0,0));
		return
	
	if already_saved && added_again > 0:
		Global.update_data();
		message_box.update_message("Updating is not implemented yet", Color(1,0,0));
		return
	
	if Global.planets_data.empty():
		message_box.update_message("Please Add Planet Before Saving!", Color(1,0,0));
	else:
		message_box.update_message("Will Save only added data!", Color(1,0,0));
		if Global.save_data():
			message_box.update_message("The Data Was Saved.", Color(1,1,1));
			added_again = 0
			already_saved = true
		else:
			message_box.update_message("Could not Save Data!", Color(1,0,0));
	
	pass
	
func Exit_pressed():
	
	print("deleted from grid")
	for i in range(0,grid.get_child_count()):
		print(grid.get_child(i))
		grid.get_child(i).queue_free()
		
	grid.queue_free()		
	
		
	Global.exit_game()
	self.get_tree().quit()
	pass