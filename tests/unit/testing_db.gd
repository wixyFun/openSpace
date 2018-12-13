extends "res://tests/menu/unittest.gd"

# class member variables go here, for example:
const SQLite = preload("res://db.gd")
var db = SQLite.new()
const db_file = "res://godot_testing.sql"
var result

func tests():
	
	testcase("testing db.gd")
	assert_true(db.plugin_ready == true, "library has loaded")
	endcase()
	
	testcase("testing prepare_db")
	db.prepare(db_file)
	assert_true(db == true, "db_file can be opened")
	endcase()
	
	testcase("testing get_tableReady() and fetch_all_tables()")
	
	var query = "CREATE TABLE IF NOT EXISTS 'orange' (";
	query += "id integer PRIMARY KEY,";
	query += "Name text NOT NULL,";
	query += "Mass float NOT NULL,";
	query += "Radius float NOT NULL,";
	query += "X float NOT NULL,";
	query += "Y float NOT NULL,";
	query += "Z float NOT NULL,";
	query += "Vx float NOT NULL,";
	query += "Vy float NOT NULL,";
	query += "Vz float NOT NULL";
	#query += "Orbiting text NOT NULL";
	query += ");";
	
	result = db.get_tableReady(query)
	assert_true(result == true, "table creation sucsessfull")
	
	result = db.fetch_all_tables(db_file)
	
	assert_true(result.find("orange") == true, "table was created")
	endcase()
	
	testcase("testing closing_db")
	db.close_db()
	assert_true(db == null, "db_file can be closed")
	endcase()
	
	
	
