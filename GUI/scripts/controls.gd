extends Node

# class member variables go here, for example:
#dictionary for buttons and other small controls 
var controls_dict = {}
var button_template = preload("res://GUI/scripts/Main_button.gd")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func get_parallelControls_ready(labels_list):
	
	var index = labels_list.size()
	
	for i in range(index):
		
		controls_dict[i] = [Label.new(), LineEdit.new()]
	
	for i in range (index):
		controls_dict[i][0].text = labels_list[i]
		controls_dict[i][1].editable = true
		controls_dict[i][1].expand_to_text_length = true
		controls_dict[i][1].max_length = 20
		#controls_dict[1][1].placeholder_text = "only float values"
	
	pass
	
func get_data_labels(labels_text):
	
	for label in labels_text:
		controls_dict[label] = Label.new()
		controls_dict[label].text = label
		
	pass
	
func load_lineEdits(index, labels_quant):
	
	var name = str(index)+"_planet"
	controls_dict[name] = []
	
	#for each label
	for i in range (labels_quant):
		var new_txtEdit = LineEdit.new()
		new_txtEdit.editable = true
		new_txtEdit.expand_to_text_length = true
		new_txtEdit.max_length = 20
		new_txtEdit.placeholder_text = str(i)	
		#new_txtEdit.text = str(planets_data[index][i])
		controls_dict[name].append(new_txtEdit)
	
	pass
	
	
func get_button_controls(but_list):
	
	for but_name in but_list:
		controls_dict[but_name] = button_template.new()
		controls_dict[but_name].text = but_name
		
	return but_list

func get_option_control(button_name, first_selected,items_list):
	
	controls_dict[button_name] = OptionButton.new()
	
	controls_dict[button_name].add_item(first_selected)
	controls_dict[button_name].select(0)
	controls_dict[button_name].set_item_disabled(0, true)
	
	#projects are added in the order they are in the
	#projects_saved
	for items in items_list:
		controls_dict[button_name].add_item(str(items))
	pass
	