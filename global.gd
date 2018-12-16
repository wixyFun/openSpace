extends Node
# global.gd is a singleton that is autoloaded and provides a global way of keeping record in the game


# class member variables go here
var current_scene 
var start_screen = "res://GUI/Start_scene.tscn"
var play_scene = "res://GUI/NBodyScene.tscn"
var load_prev_scene = "res://GUI/Load_prev_scene.tscn"
var prev_scene

#the number of the parameters for the planet's data
var SQLite = preload("res://top_db.gd")
var db = SQLite.new()
var current_table

var projects_saved = []
var projects_deleted = []


#dictionary to keep the data for the planets
#number of the planet as a key and values are in the array of floats
var planets_data = {}
var planets_params = 10

#index of the array is index of the planet
#value is the planet the index orbiting
var orbits = []

var already_saved
var added_again
var update_orbits = false

var db_file = "res://godot.sql"

signal update_message(prompt, color)
signal add_orbits(planet_index)

#TODO:validate orbits method

func _ready():
	
	# set the start sceen
	current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	
	#to control save action
	already_saved = 0
	added_again = 0
	current_table = ""
	
	db.connect("set_current_table",self,"set_current_table")
	
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
				
func clean_up_planets():
	if !Global.planets_data.empty():
		var planets= Global.planets_data.keys()
		
		for planet in planets:
			Global.planets_data.erase(planet)

	pass


#check all planets for duplicates	
func has_data_duplicates(temp_data):
	
	for i in range(planets_data.size()):
		if planets_data[i][0] == temp_data[0]:
			emit_signal("update_message", "Name of the Planet is already in use. Please change it!",Color(1,0,0));
			return true
			
		if (planets_data[i][3] == temp_data[3] && \
			planets_data[i][4] == temp_data[4] && \
			planets_data[i][5] == temp_data[5]):
				emit_signal("update_message", "Coordinates of the Planet are already in use by " + planets_data[i][0] + " .Please change it!",Color(1,0,0));
				return true
		
	return false
	
func exit_game():
	
	if current_scene != null :
	   #clean up the current scene
		for i in range(0,current_scene.get_child_count()):
		
			current_scene.get_child(i).queue_free()
	current_scene.queue_free()
	
	db.queue_free()
	pass
	


func _process(delta):
	
	#if controls_dict.has("projects"):
	#	controls_dict["projects"].set_scale(Vector2(1.5, 1.5))
		
	pass


func update_deleted_projects(project):
	
	projects_deleted.append(project)
	pass
	
	#if error, return error message
func was_project_deleted(table_name):
	 
	if projects_deleted.find(table_name) != -1:
		return true
		
	return false	

func update_saved_projects(name):
	Global.projects_saved.append(name);
	pass
	
func load_saved_projects():
	
	var temp = db.has_saved_games()
	
	if temp != null:
		
		for project in temp:
			projects_saved.append(project.name)
					
	if projects_saved.empty():
		return false
		
	return true
	
#params: STRING -text entered and the index for the label of the textLine
func validate_data(new_text, label, index):
	
	if index > 2:
		if index == 9:
			return validate_orbit(new_text,label)
		else:
			return validate_floats(new_text, label)
	else:
		return validate_positive(new_text, label)

	
func validate_floats(value, label):
	
	#not an integer or a float checked
	if !(value.is_valid_float()):
		emit_signal("update_message", ("You Have Entered Wrong Value for ' " + label + "'. Please Re-enter the value !!!"), Color(1,0,0))
		return false
	#if correct					
	emit_signal("update_message","", Color(0,0,0))
	
	return true

#for mass and radius, name is omitted
func validate_positive(value, label):

	if value.to_float() <=0:
		emit_signal("update_message", "Can be Only Positive Numeric Values. Reenter Value for: '"+label+"'", Color(1,0,0))
		return false
	#if correct					
	emit_signal("update_message","", Color(0,0,0))
	
	return true

	
func add_data(temp_array):
	

	var planet_key = Global.planets_data.size() 

	var valueArray = []
	var temp
	var change = true
	
	#re-validate
	for i in range(temp_array.size()):
		if i != 0:#name
			if !self.validate_data(temp_array[i], "", i): 
				change = false
	
	if !change:
		emit_signal("update_message","Cannot Add Given Values, Please Reenter", Color(1,0,0))
	else:
		
		#move from text to approp data type	
		valueArray.append(str(temp_array[0]))
		
		for i in range(1,Global.planets_params-1):
			valueArray.append(temp_array[i].to_float())
		
		#check name, x,y,z for duplicate under endex-[0,3,4,5]
		if !self.has_data_duplicates(valueArray):
			planets_data[planet_key] = valueArray
			
			orbits.append(-1)
			db.orbits_inDB.append(-1)
			added_again +=1
			
			emit_signal("add_orbits", planets_data.size()-1)

			emit_signal("update_message","Added Another Planet. So Far There are: " + str(planet_key + 1) + " planets", Color(2,2,2))

	pass
	
func save_toDB():
	
	if db.save_data(planets_data, orbits,already_saved):
		emit_signal("update_message","The Data Was Saved.", Color(1,1,1));
		added_again = 0
		already_saved += 1
		db.update_orbitsDB()
		update_orbits = false
	else:
		emit_signal("update_message", "Could not Save Data!", Color(1,0,0));
	
	pass
	
func update_toDB(which_param):
	
	if which_param == 9:
		db.update_orbitsDB()
	
	pass
	
func set_current_table(table):
	
	current_table = table
	pass
	
func load_planets_data(table):
	
	planets_data = db.load_from_table(table)
	
	if planets_data.empty():
		emit_signal("update_message", "Project "+str(table)+" is empty or delted!!", Color(1,0,0))
		return false
	return true
	
func drop_projects(project):
	
	var result = false
	result = db.drop_table(db_file,project)
	
	if result:
		update_deleted_projects(project)
		clean_up_planets()
	else:
		emit_signal("update_message", "Cannot Delete Project. Please Try Later", Color(1,0,0))
	
		
	return result
	
func validate_orbit(new_text,label):
	
	return true
	
func set_prev_scene(scene):
	prev_scene = scene
	
	pass
		
