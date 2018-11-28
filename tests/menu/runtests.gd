extends SceneTree  

func _init():  
    load('res://tests/menu/unittest.gd').run([
        'res://tests/menu/testing_global.gd',
		'res://tests/menu/testing_menu_grid.gd',
    ])
    quit()