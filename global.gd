extends Node
# global.gd is a singleton that is autoloaded and provides a global way of keeping record in the game


# class member variables go here
var current_scene 
var start_screen = "res://GUI/Start_scene.tscn"
var play_scene = "res://GUI/NBodyScene.tscn"
var load_prev_scene = "res://GUI/Load_prev_scene.tscn"
var end_screen = start_screen

#the number of the parameters for the planet's data
var SQLite = preload("res://top_db.gd")
var db = SQLite.new()

var projects_saved = []
var projects_deleted = []


#dictionary to keep the data for the planets
#number of the planet as a key and values are in the array of floats
var planets_data = {}
var planets_params = 10

#index of the array is index of the planet
#value is the planet the index orbiting
var orbits = []


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
				
func clean_up_planets():
	if !Global.planets_data.empty():
		var planets= Global.planets_data.keys()
		
		for planet in planets:
			Global.planets_data.erase(planet)
	print("the planets info after cleanup")
	print(Global.planets_data)
	
	pass


#check all planets for duplicates	
func has_data_duplicates(index_list,temp_data):
	
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
	
	for project in temp:
		projects_saved.append(project)
		
	if projects_saved.empty():
		return false
		
	return true

	