"""
class base_grid is responsble for basic functions extended from 
the GridContainer to accomdate the grid's basic behaviour for the game
methods: _ready()
		remove_from_grid()
		add_to_grid()
		update_theme()
		add_parallelControls()
"""


extends GridContainer

var grid_theme = Theme.new()
const Controls = preload("res://GUI/scripts/controls.gd")
var controls = Controls.new()
var controls_dict = controls.controls_dict #all the control buttons

var Center = preload("res://GUI/scripts/center_container.gd")
var center_container = Center.new()

var Mbox = preload("res://GUI/scripts/message_box.gd")
var message_box = Mbox.new()

var Scroll = preload("res://GUI/scripts/scroll_container.gd")
var scroll_container = Scroll.new() 


func _ready():

	self.set_theme(grid_theme)
	pass

#rename remove controls from the grid
func remove_from_grid(list):

	for child in list:
		if controls_dict.has(child):
			self.remove_child(controls_dict[child])

	pass
	
func set_up(col_num, vSep, hSep):
	
	self.columns = col_num
	self.update_theme("vseparation", vSep)
	self.update_theme("hseparation", hSep)
	
	pass

#rename add controls to grid
func add_to_grid(b_list, data_source):

	for item in b_list:
		if data_source.has(item):
			self.add_child(data_source[item])

	pass

func update_theme(separation,value):

	grid_theme.set_constant(separation, "GridContainer", value)

	pass
	
func add_labels(value_size):

	for i in range (value_size):
		self.add_child(controls_dict[i][0])

	pass

func add_textEdits(value_size):

	for i in range (value_size):
		self.add_child(controls_dict[i][1])

	pass
	
func add_parallelControls(list, data_source):

	for i in range (list.size()):

		self.add_child(data_source[i][0])
		self.add_child(data_source[i][1])

	pass

#TODO: get a recursive clean_up	
func clean_up():
	
	for child in  self.get_children():
		for inChild in child.get_children():
			inChild.queue_free()
		child.queue_free()
		self.remove_child(child)
	
	pass