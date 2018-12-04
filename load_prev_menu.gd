"""
load_prev menu is the menu screen, appears after start menu->load prev pressed
contains: buttons with the prev. saved projects' names 
"""

extends Node2D

var center_container = CenterContainer.new()
var Grid = preload("res://menu_grid.gd")
var grid = Grid.new()
var message_box = CenterContainer.new()
var message_label = Label.new()

func _ready():
	
	self.get_message_ready()
	
	message_box.add_child(message_label)
	self.add_child(message_box)
	self.get_loadPrev_menu_ready()
	
	center_container.add_child(grid)
	self.add_child(center_container)
	pass
	
func get_message_ready():
	
	message_box.use_top_left = true
	message_box.set_margin(MARGIN_TOP, 30)
	message_box.set_margin( MARGIN_LEFT, 170)
	message_label.text = "Choose Project to Load.";
	
	pass

func get_loadPrev_menu_ready():
	
	# Called when the node is added to the scene for the first time.
	self.get_container_ready()
	Global.get_loadPrev_buttons()
	self.set_loadPrev_controls()
	
	pass

#TODO: the scroll if the number/size of the buttons exceeds the screen
func set_loadPrev_controls():
	
	grid.grid_theme.set_constant("vseparation", "GridContainer", 20)
	grid.grid_theme.set_constant("hseparation", "GridContainer", 40)
	grid.columns = 1
	
	for i in range(Global.projects_saved.size()):
		var name = Global.projects_saved[i]
		grid.controls_dict[name].connect("pressed", self, "project_pressed", [name,]);
		grid.add_child(grid.controls_dict[name])
	pass
	
func project_pressed(which):
	print(which)
	if Global.load_fromTable("'"+which+"'"):
		print("data added form the project")
		#Global.set_scene("res://NBodyDemo.tscn")
		#Global.set_scene("res://play_scene.tscn")
	else:
		update_message("This Project Could not be loaded", Color(1,0,0));
	pass
	
func get_container_ready():
	
	center_container.use_top_left = true
	#center_container.set_margin( MARGIN_BOTTOM, 200)
	center_container.set_margin( MARGIN_RIGHT, 200)
	center_container.set_margin(MARGIN_TOP, 250)
	center_container.set_margin(MARGIN_LEFT, 200)
	
	pass
	
func play_pressed():
	
	Global.set_scene("res://main_menu_scene.tscn")
	
	pass

func update_message(prompt, colored):
	message_label.text = prompt
	message_label.add_color_override("font_color", colored)
	message_label.ALIGN_RIGHT
	message_label.update()
	pass

func exit_pressed():
	
	print("deleted from grid")
	for i in range(0,grid.get_child_count()):
		print(grid.get_child(i))
		grid.get_child(i).queue_free()
		
	message_label.queue_free()	
	grid.queue_free()		
			
	Global.exit_game()
	self.get_tree().quit()
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
