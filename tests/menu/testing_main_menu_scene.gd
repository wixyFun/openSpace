extends "res://tests/menu/unittest.gd"

func tests():
	
	testcase("testing main_menu_scene.gd")
    #print("testing the sample test")
	var Menu = load('res://main_menu_scene.gd')
	var menu = Menu.new()
	
	
	assert_true(menu != null, "should be true")
	
	#assert_eg(global.controls_dict.size(), 12 , "true")
	
	endcase()
	
	testcase("testing main_menu")
    #print("testing the sample test")
	
	menu.get_message_ready()
	print(menu.get_child_count())
	
	
	assert_false(menu.get_child_count() != 0, "false")
	#assert_false(global.controls_dict == null, "false")
	#assert_eg(global.controls_dict.size(), 12 , "true")
	
	endcase()
	
