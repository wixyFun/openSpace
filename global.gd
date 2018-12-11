extends Node
# global.gd is a singleton that is autoloaded and provides a global way of keeping record in the game

"""
TODO:Global singleton will keep track of the flow of the game and will have
				2 class variables: controls(to manage all buttons) and db(to manage db data manipulation) 
"""

# class member variables go here
var current_scene 
var start_screen = 'res://menu_gui/start_scene.tscn'
#var display = preload("res://display_set.gd")
#var end_screen

#the number of the parameters for the planet's data
var data_len = 10
var SQLite = preload("res://db.gd")
var db = SQLite.new()
var table_name
var projects_saved = []
var projects_deleted = []

#dictionary to keep the data for the planets
#number of the planet as a key and values are in the array of floats
var planets_data = {}

#dictionary for buttons and other small controls 
var controls_dict = {}
var button_template = preload("res://menu_gui/scripts/Main_button.gd")


func _ready():
	
	# set the start sceen
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	#set_process(true)
	#print(controls_dict.size())
	#print(current_scene.filename)
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
	
func clean_up_planets():
	if !Global.planets_data.empty():
		var planets= Global.planets_data.keys()
		
		for planet in planets:
			Global.planets_data.erase(planet)
	print("the planets info after cleanup")
	print(Global.planets_data)
	
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
		new_txtEdit.text = str(planets_data[index][i])
		controls_dict[name].append(new_txtEdit)
	
	pass
	
func get_button_controls(but_list):
	
	for but_name in but_list:
		controls_dict[but_name] = button_template.new()
		controls_dict[but_name].text = but_name
		
	return but_list
	
func has_saved_games():

	if db.prepare_db():
		db.fetch_allTables();
		
		db.close_db();
		if !projects_saved.empty():
			print(projects_saved)
			return true
	
	return false

#check all planets for duplicates	
func has_duplicates(index_list,temp_data):
	
	for index in range(planets_data.size()):
		if recursive_check(index, index_list,temp_data):
			return true
			
	return false

#checks one planet for duplicate: true if has duplicates	
func recursive_check(index,index_list,temp_data):
	print("in recursive:")
	print(index)
	print(index_list)
	print(temp_data)
	if index_list.size() == 0:
		return false
	else:
		if temp_data[index_list[0]] == planets_data[index][index_list[0]]:
			return true
		else:
			index_list.pop_front()
			return recursive_check(index,index_list, temp_data)
	
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
	
func load_fromTable(table):
	
	var result
	var planets_data = {}
	
	if db.prepare_db():
		var statement = "SELECT * FROM %s";
		var query = statement % table
		result = db.db.fetch_array(query);
		
		for i in range(result.size()):
			Global.planets_data[result[i].id] = [result[i].Name,result[i].Mass,result[i].Radius,result[i].X, result[i].Y, result[i].Z, result[i].Vx, result[i].Vy, result[i].Vz];#, result[i].Orbiting];
			print(Global.planets_data[result[i].id])
		
		
		print("all the data from the table")
		print(result)
		
		db.close_db();
		return true
	
	return false
	
func get_data(table):
	
	var result
	
	if db.prepare_db():
		var statement = "SELECT * FROM %s";
		var query = statement % table
		print(query)
		result = db.db.fetch_array(query);
		print(result)
		db.close_db();
	
	return result

func _process(delta):
	
	#if controls_dict.has("projects"):
	#	controls_dict["projects"].set_scale(Vector2(1.5, 1.5))
		
	
	pass

func drop_project(table_name):
	
	var result
	print("dropping the project")
	
	if db.prepare_db():
		
		var statement = "DROP TABLE'%s';"
		var query = statement % table_name
		print(query)
		result = db.db.query(query)
		print(result)
		db.close_db();
		projects_deleted.append(table_name)
	
	return result
	#if error, return error message
func was_project_deleted(table_name):
	 
	if projects_deleted.find(table_name) != -1:
		return true
		
	return false	


	