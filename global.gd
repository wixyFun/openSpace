extends Node
# global.gd is a singleton that is autoloaded and provides a global way of keeping record in the game

"""
Global singleton will keep track of the buttons dict and planets_data, which  
will be globally available in the game 
"""

# class member variables go here
var current_scene 
#var start_screen = 'res://main_menu_scene.tscn'
#var end_screen

#the number of the parameters for the planet's data
var data_len = 7
#var SQLite = preload("res://sqlite_db.gd")

#dictionary to keep the data for the planets
#number of the planet as a key and values are in the array of floats
var planets_data = {}

#dictionary for buttons and other small controls 
var controls_dict = {}
var button_template = preload("res://Main_button.gd")


func _ready():
	# Called when the node is added to the scene for the first time.
	# set the start sceen
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	
	#print(controls_dict.size())
	#print(current_scene.filename)
	pass

func game_over():

	#get_tree().change_scene(end_screen)
	pass

#clean the prev scene and move to the param scene
func set_scene(scene):
	
	if current_scene != null :
	   #clean up the current scene
	   current_scene.queue_free()
	
	var scene_res = ResourceLoader.load(scene)
	current_scene= scene_res.instance()
	get_tree().get_root().add_child(current_scene)
	
	pass
	
		
		
func update_data(key, index, value):
	
	planets_data[key][index] = value
	

func save_data():
	
	#set the db obect
	#var db = SQLite.new()
	print("inside the save_data")
	#db.open()
	
	
	
	pass
	
func get_startButtons_ready(all):
	
	controls_dict["new_game"] = button_template.new()
	controls_dict["new_game"].text = "Play New Game"
	
	controls_dict["exit"] = button_template.new()
	controls_dict["exit"].text = "Exit Game"	
	
	if all:
		controls_dict["prev_game"] = button_template.new()
		controls_dict["prev_game"].text = "Load Previous Games"
		
	pass
		
func get_mainControls_ready():
	
	controls_dict["play"] = button_template.new()
	controls_dict["play"].text = "Play"
	
	controls_dict["add"] = button_template.new()
	controls_dict["add"].text = "Add Planet"
	
	var labels_text = ["Enter Mass", "Enter x ", "Enter y ", "Enter z ", "Enter Vx ", "Enter Vy ", "Enter Vz "]
	
	var index = labels_text.size()
	
	for i in range(index):
		
		controls_dict[i] = [Label.new(), LineEdit.new()]
	
	for i in range (index):
		controls_dict[i][0].text = labels_text[i]
		controls_dict[i][1].editable = true
		controls_dict[i][1].expand_to_text_length = true
		controls_dict[i][1].max_length = 5
		#controls_dict[1][1].placeholder_text = "only float values"
	
	pass
	
#TODO will check if there are games in db	
func has_saved_games():
	
	return false
	
func exit_game():
	
	print("deleted from global")
	if current_scene != null :
	   #clean up the current scene
		for i in range(0,current_scene.get_child_count()):
			print(current_scene.get_child(i))
			current_scene.get_child(i).queue_free()
	current_scene.queue_free()
	
	
	

	