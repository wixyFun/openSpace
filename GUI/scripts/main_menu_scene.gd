"""
Class main_menu_scene is responsible for the start and main menus'
functionality/buttons response
"""


extends Node2D

# class member variables go here, for example:

var Grid = preload("res://GUI/scripts/menu_layout.gd")
var layout = Grid.new()


#layout helpers
var outer_center = CenterContainer.new()
var hBox = HBoxContainer.new()
var vBox = VBoxContainer.new()

var data_labels
var buttons_list

var controls_dict = layout.controls.controls_dict
var message_box = layout.message_box
var center_container = layout.center_container


signal add_data(temp_data)
signal validate_data(new_text, label, index)
signal save_data()
signal update_orbitsDB(which)




func _ready():
	
	message_box.get_mbox_ready("Enter Numeric Data for Coordinates, Velocity, Radius and Mass.")
		
	self.map_layout()
	layout.connect("orbit_defined", self, "set_orbits_controls")
	self.connect("update_orbitsDB",Global, "update_toDB")
	pass
	
func map_layout():
	
	vBox.set_margin(MARGIN_TOP, 20)#spacing for its child-message box 
	center_container.set_frame(1,1,1,0)
	center_container.set_sizeTo_screen(0.75)
	
	self.add_child(vBox)
	vBox.add_child(message_box)
	vBox.add_child(center_container)
	center_container.add_child(hBox)
	hBox.add_child(layout)
	hBox.add_child(layout.orbit_grid)

	pass
	
func set_lists(btn_list, labl_list):
	
	data_labels = labl_list
	buttons_list = btn_list
	
	pass
	
func ready_menu():
	
	layout.get_main_ready(buttons_list,data_labels)
	self.set_main_controls()
	
	#for signals to
	self.connect("validate_data", Global, "validate_data")
	self.connect("add_data", Global, "add_data")
	self.connect("save_data", Global, "save_toDB")
	
	#for signals from
	Global.connect("update_message", self, "update_message")
	Global.connect("add_orbits", layout,"add_orbits")
	
	
	pass
	
func set_main_controls():
	
	for butn in buttons_list:
		if butn != "Simulate":# is in the demoscene script
			controls_dict[butn].connect("pressed", self, str(butn+"_pressed"))
	
	#no orbiting		
	for i in range(1,Global.planets_params-1):# i is the label index
		controls_dict[i][1].connect("text_changed", self, "validate_data", [i,])

	pass

#params: STRING -text entered and the index for the label of the textLine
func validate_data(new_text, label_index):
	
	emit_signal("validate_data",new_text,str(controls_dict[label_index][0].text), label_index)
	
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
	
	if value.to_float() <=0:
		message_box.update_message("Can be Only Positive Numeric Values. Reenter Value for: '"+label+"'", Color(1,0,0))
		return false
	#if correct					
	message_box.update_message("", Color(0,0,0))
	
	return true

	
func Add_pressed():
	

	var valueArray = []
	var temp
	
	#get all the values from the labels
	for i in range(Global.planets_params-1):
		temp = controls_dict[i][1].text
		valueArray.append(temp)
		
	emit_signal("add_data",valueArray)
			

	pass

#TODO: add update data if user will press more than once on save button	
func Save_pressed():
	var already_saved = Global.already_saved
	var added_again = Global.added_again
	
	if already_saved > 0 && added_again == 0 && !Global.update_orbits:
		message_box.update_message("This Data was Already Saved!", Color(1,0,0));
		print("save case 1")
		return
	
	if already_saved > 0 && added_again > 0:
		message_box.update_message("Will Save only added data!", Color(1,0,0));
		print("save case 2")
		emit_signal("save_data")
		return
		
	if already_saved == 0 && added_again == 0:
		message_box.update_message("Please Add Planet Before Saving!", Color(1,0,0));
		print("save case 3")
		return
		
	if already_saved == 0 && added_again > 0:
		message_box.update_message("Will Save only added data!", Color(1,0,0));
		print("save case 4")
		emit_signal("save_data") 
		return
		
	if already_saved > 0 && added_again == 0 && Global.update_orbits:
		print("save case 5")
		message_box.update_message("Will Save Orbits!", Color(1,0,0));
		emit_signal("update_orbitsDB", 9) 
		return
		 
	
	
func Exit_pressed():

	for i in range(0,layout.get_child_count()):
	
		layout.get_child(i).queue_free()
		
	layout.queue_free()		
	
		
	Global.exit_game()
	self.get_tree().quit()
	pass
	
func set_orbits_controls(name, planet_index):
	
	controls_dict[name].connect("item_selected", self, "orbit_selected", [name,planet_index,]);
	
	pass
	
func orbit_selected(which, name, planet_key):
	
	var orbits_name 
	
	for i in range(Global.planets_data.size()):
		if Global.planets_data[i][0] == name:
			orbits_name = layout.controls.controls_dict[name].get_item_text(which)
	
			
	for i in range(Global.planets_data.size()):
		if Global.planets_data[i][0] == orbits_name:
			Global.orbits[planet_key] = i
			Global.update_orbits = true
	
				
	pass
	
func update_message(text, color):
	
	message_box.update_message(text,color)
	
	pass