extends "res://tests/menu/unittest.gd"

var result

func tests():
	
	testcase("testing Global.gd")
	var Globals = load("Global.gd")
	var gb = Globals.new()
	
	assert_true(gb != null, "class loaded true")
	endcase()
	
	
	testcase("testing set values on scenes")
	
	assert_true(gb.start_screen == "res://GUI/Start_scene.tscn", "start scene is set")
	assert_true(gb.play_scene == "res://GUI/NBodyScene.tscn", "play scene is set")
	assert_true(gb.load_prev_scene == "res://GUI/Load_prev_scene.tscn", "load prev scene is set")
	endcase()
	
	testcase("testing add data")
	
	gb.add_data(['blue', '1','2','3','4','5','6','7','8'])
	
	assert_true(gb.planets_data.size() == 1, "only 1 data key-value was added")
	assert_false(gb.planets_data.empty(), "data was added")
	
	endcase()
	
	testcase("testing duplicates detection")
	
	var temp_data = ['orange', 1,2,3,4,5,6,7,8]
	
	result = gb.has_data_duplicates(temp_data)
	
	assert_true(result == true, "data has duplicates")
	
	temp_data = ['purple', 1,0,0,0,5,6,7,8]
	
	result = gb.has_data_duplicates(temp_data)
	assert_false(result == true, "data has no duplicates")
	
	temp_data = ['blue', 1,0,0,0,5,6,7,8]
	
	result = gb.has_data_duplicates(temp_data)
	assert_true(result == true, "data has duplicates-name")
	endcase()
	
	
	testcase("testing validate floats/numeric values")
	
	result = gb.validate_floats('0', "")
	assert_true(result == true, "value is numeric")
	result = gb.validate_floats('ggg', "")
	assert_false(result == true, "value is not numeric")
	result = gb.validate_floats('1.5', "")
	assert_true(result == true, "value is numeric")
	endcase()
	
