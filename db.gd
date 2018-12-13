"""
class db performs general CRUD operations 
		that do not depend on the application
"""

extends Node

# class member variables go here, for example:
const SQLite = preload("res://lib/gdsqlite.gdns")
var plugin = SQLite.new()
var plugin_ready = false

var exits_statement = "SELECT name FROM sqlite_master WHERE type='table' AND name='%s';" 

func _ready():
	
	plugin.init()
	if ! plugin == null:
		plugin_ready = true
	print("inside the ready of the db")
	
	pass
	
func save(file,table_query,table,query):
	
	var result
	
	if prepare_db(file) && get_tableReady(table_query):
		result = plugin.query(query)
		close_db()
		
	return result
	
func change(file, table, query):
	
	var result = false
	var query1 = exits_statement % table 
	
	if prepare_db(file):
		if table_exists(query1) == 1:
			result = plugin.query(query)
	close_db()
			
	return result
	
func drop_table(file, table):
	
	var result
	var statement = "DROP TABLE IF EXISTS '%s';"
	var query = statement % table
	
	if prepare_db(file):
		result = plugin.query(query)
		
	return result
		
#open the database 
func prepare_db(file):
	
	print("inside the open in db")
	if !plugin.open_db(file):
		return false
	return true

#TODO fins a way to see if table exists already
func get_tableReady(query):
	
	var result = plugin.query(query);
	print(result)

	return result


func close_db():
	plugin.close()
	pass

func fetch_all_tables(file):
	
	var query = "SELECT name FROM sqlite_master WHERE type='table'"
	
	var result 
	
	if prepare_db(file):
		result = plugin.fetch_array(query);
		
	return result
	
	
func fetch_data(file, table, query):
	
	var result 
	var query1 = exits_statement % table 
	 
	if prepare_db(file):
		if table_exists(query1) == 1:
			result = plugin.fetch_array(query);
	close_db()
			
	return result
	
func is_plugin_ready():

	return plugin_ready
	
	

