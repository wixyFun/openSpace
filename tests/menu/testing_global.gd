extends "res://unittest.gd"

func tests():
	
	testcase("testing global.gd")
    #print("testing the sample test")
	var global = preload("res://Global.gd").new()
	
	
	assert_true(global != null, "should be true")
	assert_false(global.controls_dict == null, "false")
	#assert_eg(global.controls_dict.size(), 12 , "true")
	
	endcase()
	
