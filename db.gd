"""
class db.gd will customize the use of the sqlite db 
for the game
"""

extends Node

# class member variables go here, for example:
const SQLite = preload("res://lib/gdsqlite.gdns")
var db = SQLite.new()

func _ready():
	
	db.init()
	if db == null:
		print("db library was not loaded")
	print("inside the ready of the db")
	
	pass
	
#open the database and make sure table is there
func prepare_db():
	
	print("inside the open in db")
	if !db.open_db("res://godot.sql"):
		return false
	return true

func get_TName():
	return "planets_"+str(self.getTimeStamp())
	
#TODO fins a way to see if table exists already
func get_tableReady(tableName):
	
	# Create table if it does not exist
	var query = "CREATE TABLE IF NOT EXISTS " + tableName + "(";
	query += "id integer PRIMARY KEY,";
	query += "Mass float NOT NULL,";
	query += "X float NOT NULL,";
	query += "Y float NOT NULL,";
	query += "Z float NOT NULL,";
	query += "Vx float NOT NULL,";
	query += "Vy float NOT NULL,";
	query += "Vz float NOT NULL";
	query += ");";
	
	print("finished checking table")
	
	var result = db.query(query);
	print(result)

	return result
	
func save_toDB(table):
		
	var data = Global.planets_data;
	var statement 
	var query
	var result
	
	for i in range(data.size()):
		statement = "INSERT INTO " + table 
		statement += "(id, Mass, X, Y, Z, Vx, Vy, Vz)"
		statement += "VALUES('%s','%s','%s','%s','%s','%s','%s','%s');"
	
		
		var parami = str(i)
		var param0 = str(data[i][0]) 
		var param1 = str(data[i][1]) 
		var param2 = str(data[i][2]) 
		var param3 = str(data[i][3]) 
		var param4 = str(data[i][4]) 
		var param5 = str(data[i][5]) 
		var param6 = str(data[i][6]) 
		
		query = statement % [parami,param0,param1,param2,param3,param4,param5,param6]
				
		result = db.query(query)
	print("result of insert")
	print(result)
	return result
	
func close_db():
	db.close()
	pass
	
func getTimeStamp():
	
	var stamp_dict = OS.get_datetime();
	
	var year = stamp_dict.year;
	var month = stamp_dict.month;
	var day = stamp_dict.day;
	var hour = stamp_dict.hour;
	var minute = stamp_dict.minute;
	var sec = stamp_dict.second;
	
	var stamp = str(year)+"/"+str(month)+"/"+str(day)+"_"+str(hour)+":"+str(minute)+":"+str(sec)
	print(stamp)
	return stamp
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
