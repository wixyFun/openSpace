"""
start menu is the first screen in the simulation
contains: load previous games if exit
		  exit the game
		  play the game
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
	self.get_start_menu_ready()
	
	center_container.add_child(grid)
	self.add_child(center_container)
	pass
	
func get_message_ready():
	
	message_box.use_top_left = true
	message_box.set_margin(MARGIN_TOP, 30)
	message_box.set_margin( MARGIN_LEFT, 170)
	
	pass

func get_start_menu_ready():
	
	# Called when the node is added to the scene for the first time.
	self.get_container_ready()
	
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
	grid.controls_dict["new_game"].connect("pressed", self, "play_pressed")
	
	if all:
		grid.controls_dict["prev_game"].connect("pressed", self, "prevGame_pressed")
		
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
	
func prevGame_pressed():
	
	print("prevGame pressed")
	Global.set_scene("res://load_prev_scene.tscn");
	
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
