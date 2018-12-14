"""
class top_db will contain CRUD oprations with the 
			specific to the game queries 
"""

extends "res://db.gd"

var db_file = "res://godot.sql"
var orbits_inDB = []

signal set_current_table(table)


func _ready():
	
	#ready = plugin.is_plugin_ready()
	
	pass
	
func get_insert_statement():
	
	var insert_statement = "INSERT INTO '%s'" 
	insert_statement += "(id, Name, Mass, Radius, X, Y, Z, Vx, Vy, Vz, Orbiting)"
	insert_statement += "VALUES('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')"

	return insert_statement

func has_saved_games():
	
	var table_list = fetch_all_tables(db_file)
	
	return table_list
	
func save_data(data_dict,orbit_array,saved):
	
	var statement = self.get_insert_statement()
	var table_name
	
	if Global.current_table.empty():
		table_name = self.get_table_name();
	else:
		table_name = Global.current_table
		
	var table_query = self.get_table_query(table_name);
	var param_array = []
	
	#adujust query to the size of the data (more than 2 rows to save)
	var dif = data_dict.size()-saved
	#print("number of extra lines added " + str(dif))
	
	for i in range(1,dif):
		statement += ",('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')"
	statement += ";"
	
	
	for i in range(saved, data_dict.size()):
		param_array.append(str(i))
		param_array.append(str(data_dict[i][0])) 
		param_array.append(str(data_dict[i][1])) 
		param_array.append(str(data_dict[i][2])) 
		param_array.append(str(data_dict[i][3])) 
		param_array.append(str(data_dict[i][4])) 
		param_array.append(str(data_dict[i][5])) 
		param_array.append(str(data_dict[i][6])) 
		param_array.append(str(data_dict[i][7])) 
		param_array.append(str(data_dict[i][8])) 
		param_array.append(str(orbit_array[i]))
		orbits_inDB[i] = orbit_array[i]
	
	#print(statement)
	#print(saved)
	
	param_array.push_front(str(table_name))	
	
	#print(param_array)
	var query = statement % param_array
	
	#print(query)

	if save(db_file,table_query,table_name,query):
		emit_signal("set_current_table",table_name)
		
		return true
		
	return false
	
	
func get_table_name():
	return "planets_"+str(self.getTimeStamp())
	
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
	
func get_table_query(table_name):
	
	# Create table if it does not exist
	var query = "CREATE TABLE IF NOT EXISTS '" + table_name + "' (";
	query += "id integer PRIMARY KEY,";
	query += "Name text NOT NULL,";
	query += "Mass float NOT NULL,";
	query += "Radius float NOT NULL,";
	query += "X float NOT NULL,";
	query += "Y float NOT NULL,";
	query += "Z float NOT NULL,";
	query += "Vx float NOT NULL,";
	query += "Vy float NOT NULL,";
	query += "Vz float NOT NULL,";
	query += "Orbiting text NOT NULL";
	query += ");";
	
	
	return query
	
func get_data(table):
	
	var result
	var statement = "SELECT * FROM %s";
	var query = statement % table
	print(query)
	result = self.fetch_data(db_file, table, query);
	
	return result
	
func load_from_table(table):
	
	var result
	var data = {}
		
	result = get_data(table)
		
	for i in range(result.size()):
		data[result[i].id] = [result[i].Name,result[i].Mass,result[i].Radius,result[i].X, result[i].Y, result[i].Z, result[i].Vx, result[i].Vy, result[i].Vz, result[i].Orbiting];
		
	return data
	
func update_orbitsDB():
	
	var statement = "UPDATE '"+Global.current_table+"' SET Orbiting = '%s' WHERE id = '%s';"
	var query
	var result
	
	#orbit is the last in planets_data's array
	for i in range(Global.planets_data.size()):
		if Global.orbits[i] != orbits_inDB[i]:
			query = statement % [str(Global.orbits[i]), str(i)]
			#print("in the update orbits")
			#print(query)
			result = change(db_file,Global.current_table,query)
			#print("result of update "+str(result))
	
	pass
	



