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

#layout helpers
var outer_center = CenterContainer.new()
var hBox = HBoxContainer.new()
var vBox = VBoxContainer.new()

var data_labels
var buttons_list


func _ready():
	
	message_box.get_mbox_ready("Enter Numeric Data Only.")
	
	#to control save action
	already_saved = false
	added_again = 0
	
	self.map_layout()
	
	pass
	
func map_layout():
	
	vBox.set_margin(MARGIN_TOP, 20)#spacing for its child-message box 
	center_container.set_frame(1,1,1,0)
	center_container.set_sizeTo_screen(0.75)
	
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
		if butn != "Simulate":# is in the demoscene script
			Global.controls_dict[butn].connect("pressed", self, str(butn+"_pressed"))
	
	#no orbiting		
	for i in range(1,Global.data_len-1):# i is the label index
		Global.controls_dict[i][1].connect("text_changed", self, "validate_data", [i,])

	pass

#params: STRING -text entered and the index for the label of the textLine
func validate_data(new_text, label_index):
	
	if label_index > 2:
		return validate_floats(new_text, str(grid.controls_dict[label_index][0].text))
	else:
		return validate_positive(new_text, str(grid.controls_dict[label_index][0].text))
	pass
	
func validate_floats(value, label):
	
	#not an integer or a float checked
	if !(value.is_valid_float()):
		message_box.update_message("You Have Entered Wrong Value for ' " + label + "'. Please Re-enter the value !!!", Color(1,0,0))
		return false
	#if correct					
	message_box.update_message("", Color(0,0,0))
	
	return true

#for mass and radius, name is omitted
func validate_positive(value, label):
	print("in the validate positive")
	print(label)
	if value.to_float() <=0:
		message_box.update_message("Can be Only Positive Numeric Values. Reenter Value for: '"+label+"'", Color(1,0,0))
		return false
	#if correct					
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
	for i in range(Global.data_len-1):
		temp = grid.controls_dict[i][1].text
		
		if i != 0:#name
				if !self.validate_data(temp, i): 
					change = false
	
	if !change:
		message_box.update_message("Cannot Add Given Values, Please Reenter", Color(1,0,0))
	else:
		#names will be saved as a string	
		temp = str(grid.controls_dict[0][1].text)
		valueArray.append(temp)
		
		for i in range(1,Global.data_len-1):
			temp = grid.controls_dict[i][1].text.to_float()
			valueArray.append(temp)
		
		#save orbiting
		
		
		#check name, x,y,z for duplicate values-[0,3,4,5]
		if !Global.has_duplicates([0,3,4,5],valueArray):
			Global.planets_data[planet_num] = valueArray
			added_again +=1
			grid.add_orbits(Global.planets_data.size()-1)
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