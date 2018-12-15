extends "res://tests/menu/unittest.gd"


func tests():
	
	testcase("testing Global.gd")
	var Globals = load("Global.gd")
	var gb = Globals.new()
	
	assert_true(gb != null, "class loaded true")
	endcase()
	
	
		
	
	testcase("testing get_buttons_ready")
	
	gb.get_buttons_ready()
	
	assert_true(gb.controls_dict.size() != 0, "added to the controls_dict-true")
	endcase()
	
	testcase("testing get_buttons_ready")
	
	assert_true((gb.controls_dict.keys()).size() == 5, "has 5 buttons added -true")
	endcase()
	
	testcase("testing get_labels_ready")
	
	gb.get_labels_ready()
	
	assert_true((gb.controls_dict.keys()).size() > 5, "added labels as well -true")
	endcase()
	
	testcase("testing get_labels_ready")
	
	assert_true(gb.controls_dict.size() == 12, "has total 12 pairs of key, value -true")
	endcase()
	
