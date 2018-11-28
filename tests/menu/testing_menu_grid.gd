"""
testing menu_grid
"""

extends "res://unittest.gd"

func tests():
	
	testcase("testing menu_grid.gd")
    #print("testing the sample test")
	var grid = preload("res://menu_grid.gd").new()
	
	
	
	assert_true(grid != null, "should be true")
	#assert_false(global.controls_dict == null, "false")
	#assert_ne(global.controls_dict.size(),0 , "true")
	
	endcase()
	
	testcase("testing get_main_ready")
	
	assert_true(grid.get_child_count() == 0, "should be true")
	#assert_false(global.controls_dict == null, "false")
	#assert_ne(global.controls_dict.size(),0 , "true")
	
	endcase()