extends "res://tests/menu/unittest.gd"

# class member variables go here, for example:
var SQLite = load("res://db.gd")
var db = SQLite.new()

var SQ2 = load("res://top_db.gd")
var db_top = SQ2.new()
const db_file = "res://godot_testing.sql"
var result = false
var table_query
var query

var statement = "SELECT * FROM '%s'";

var exits_statement = "SELECT name FROM sqlite_master WHERE type='table' AND name='%s';" 

func tests():
	
	"""
	testcase("testing set_db_file")
	db_top.set_db_file(db_file)
	assert_true(db_top.db_file == db_file, "db was changed")
	endcase()
	"""
	
	testcase("testing prepare_db")
	result = db.prepare_db(db_file)
	assert_true(result == true, "db_file can be opened")
	endcase()
	
	testcase("testing get_table_ready()")
	
	table_query = "CREATE TABLE IF NOT EXISTS 'orange' (";
	table_query += "Name text NOT NULL";
	table_query += ");";
	
	result = db.get_tableReady(table_query)
	assert_true(result == true, "table creation sucsessfull")
	
	db.close_db()
	endcase()
	
	testcase("fetch tables")
	
	result = db.fetch_all_tables(db_file)
	assert_true(result[0].name == 'orange', "table was created")
	
	endcase()
	
	testcase("save data")
	
	query = "INSERT INTO 'orange'" 
	query += "(Name)"
	query += "VALUES('Big Orange');"
	
	result = db.save(db_file,table_query,'orange',query)
	
	assert_true(result == true, "saved data into table successful")
	
	endcase()
	
	testcase("fetch all data")
	
	query = statement % 'orange'
	result = db.fetch_data(db_file, 'orange', query);
	
	assert_true(result[0].Name == 'Big Orange', "retrieval of saved data from table successful")
	
	endcase()
