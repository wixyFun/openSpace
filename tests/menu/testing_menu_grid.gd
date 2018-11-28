"""
testing menu_grid
"""

extends "res://tests/menu/unittest.gd"

func tests():
	
	testcase("testing menu_grid.gd")
    #print("testing the sample test")
	var Grid = load('res://menu_grid.gd')
	var grid = Grid.new()
	
	var Globals = load("Global.gd")
	var gb = Globals.new()
	gb.get_buttons_ready()
	gb.get_labels_ready()
	
	assert_true(grid != null, "should be true")
	assert_true(grid.grid_theme.get_constant("vseparation", "GridContainer")== 0, "no margins set yet")
	endcase()
	
	testcase("testing get_start_ready")
	
	grid.get_start_ready()
	
	assert_true(grid.grid_theme.get_constant("vseparation", "GridContainer") == 50, "no margins set yet")
	assert_true(grid.get_child_count() == 3, "added 3 buttons to the grid-true")
	endcase()
	
	testcase("testing remove_from_grid")
	
	grid.remove_from_grid(["new_game", "prev_game", "exit"])
	
	assert_true(grid.get_child_count() == 0, "removed the buttons added-true")
	endcase()
	
	testcase("testing get_main_ready")
	
	grid.get_main_ready()
	
	assert_true(grid.get_child_count() == 2, "added left and right helper_grids-true")
	assert_true(grid.left_grid.get_child_count() == 14, "added to left helper_grid-true")
	assert_true(grid.right_grid.get_child_count() == 3, "added to right helper_grids-true")
	assert_true(grid.center_helper.get_child_count() == 1, "added to center helper_grids-true")
	endcase()