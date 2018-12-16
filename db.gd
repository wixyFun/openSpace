"""
class db performs general CRUD operations 
		that do not depend on the application
"""

extends Node

# class member variables go here, for example:
const SQLite = preload("res://lib/gdsqlite.gdns")
var db = SQLite.new()
var plugin_ready = false



var exits_statement = "SELECT name FROM sqlite_master WHERE type='table' AND name='%s';" 

func _ready():
	
	db.init()
	print("the db library "+str(db))
	if ! (db == null):
		plugin_ready = true
		print("library loaded")
	else:
		print("db_library is not loaded")
	print("inside the ready of the db")
	
	pass
	
func save(file,table_query,table,query):
	
	var result
	
	if prepare_db(file) && get_tableReady(table_query):
		result = db.query(query)
		print("in the save do query "+ str(result))
		close_db()
	
	return result
	
func change(file, table, query):
	
	var result = false
	var exists = exits_statement % table 
	
	if prepare_db(file):
		if (db.fetch_array(exists)).size() == 1:
			result = db.query(query)
		
		close_db()
			
	return result
	
func drop_table(file, table):
	
	var result
	var statement = "DROP TABLE IF EXISTS '%s';"
	var query = statement % table
	
	if prepare_db(file):
		result = db.query(query)
		close_db()
		
	return result
		
#open the database 
func prepare_db(file):
	
	print(file)
	
	
	print("inside the open in db")
	if !db.open_db(file):
		
		print("pluggin did not open")
		return false
	return true

#TODO fins a way to see if table exists already
func get_tableReady(query):
	
	var result = db.query(query);
	
	print("in the get table ready "+str(result))
	
	return result


func close_db():
	db.close()
	pass

func fetch_all_tables(file):
	
	var query = "SELECT name FROM sqlite_master WHERE type='table'"
	
	var result 
	
	if prepare_db(file):
		result = db.fetch_array(query);
		print(result)
		close_db()
		
	return result
	
	
func fetch_data(file, table, query):
	
	var result 
	var exists = exits_statement % table 
	 
	if prepare_db(file):
		if (db.fetch_array(exists)).size() == 1:
			result = db.fetch_array(query);
		close_db()
			
	return result
	
func is_plugin_ready():

	return plugin_ready
	

	
	
	

