extends Node
# global.gd is a singleton that is autoloaded and provides a global way of keeping record in the game

"""
Global singleton will keep track of the buttons dict and planets_data, which  
will be globally available in the game 
"""

# class member variables go here
var current_scene 
var start_screen = 'res://Start_scene.tscn'
#var end_screen

#the number of the parameters for the planet's data
var data_len = 7
var SQLite = preload("res://db.gd")
var db = SQLite.new()
var table_name
var projects_saved = []

#dictionary to keep the data for the planets
#number of the planet as a key and values are in the array of floats
var planets_data = {}

#dictionary for buttons and other small controls 
var controls_dict = {}
var button_template = preload("res://Main_button.gd")


func _ready():
	
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
			
func update_data():
	
	
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
	
	controls_dict["save"] = button_template.new()
	controls_dict["save"].text = "Save"
	
	controls_dict["exit"] = button_template.new()
	controls_dict["exit"].text = "Exit Game"	
	
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

	if db.prepare_db():
		db.fetch_allTables();
		
		db.close_db();
		if !projects_saved.empty():
			print(projects_saved)
			return true
	
	return false
	
func has_duplicates(temp_data):
	
	for index in range(planets_data.size()):
		if planets_data[index][1] == temp_data[1] && planets_data[index][2] == temp_data[2] && planets_data[index][3] == temp_data[3]:
			return true
	
	return false
	
func save_data():
	
	if db.prepare_db():
		table_name = "'" + db.get_TName()+ "'";
		if db.get_tableReady(table_name):
			if db.save_toDB(table_name):
				return true;
	db.close_db();
	
	return false
		
func exit_game():
	
	print("deleted from global")
	if current_scene != null :
	   #clean up the current scene
		for i in range(0,current_scene.get_child_count()):
			print(current_scene.get_child(i))
			current_scene.get_child(i).queue_free()
	current_scene.queue_free()
	
	db.queue_free()
	pass
	
func get_loadPrev_buttons():
	
	for i in range(projects_saved.size()):
		var name = projects_saved[i]
		controls_dict[name] = button_template.new()
		controls_dict[name].text = name
		
	pass
	
func load_fromTable(table):
	
	var result
	
	if db.prepare_db():
		var statement = "SELECT * FROM %s";
		var query = statement % table
		result = db.db.fetch_array(query);
		
		for i in range(result.size()):
			Global.planets_data[result[i].id] = [result[i].Mass, result[i].X, result[i].Y, result[i].Z, result[i].Vx, result[i].Vy, result[i].Vz];
			print(Global.planets_data[result[i].id])
		
		
		print("all the data from the table")
		print(result)
		
		db.close_db();
		return true
	
	return false

	
	
	
	

	