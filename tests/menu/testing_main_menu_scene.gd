extends "res://tests/menu/unittest.gd"

func tests():
	
	testcase("testing main_menu_scene.gd")
    #print("testing the sample test")
	var Menu = load('res://main_menu_scene.gd')
	var menu = Menu.new()
	
	var Globals = load("Global.gd")
	var gb = Globals.new()
	gb.get_buttons_ready()
	gb.get_labels_ready()
	
	
	assert_true(menu != null, "should be loaded-true")
	assert_true(menu.center_container != null, "was loaded-true")
	assert_true(menu.message_box != null, "was loaded-true")
	assert_true(menu.message_label != null, "was loaded-true")
	#assert_true(menu.get_child_count() == 2, "has center helper and messaage box- true")
	#assert_true(menu.message_box.get_child_count() == 1, "only lable added-true")
	#assert_true(menu.center_container.get_child_count() == 1, "has only grid -true")
	
	endcase()
	
	testcase("testing main_menu")
    #print("testing the sample test")
	
	#menu.get_message_ready()
	#print(menu.get_child_count())
	
	
	#assert_false(menu.get_child_count() != 0, "false")
	#assert_false(global.controls_dict == null, "false")
	#assert_eg(global.controls_dict.size(), 12 , "true")
	
	endcase()
	
