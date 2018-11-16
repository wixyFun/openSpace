extends SceneTree  

func _init():  
    load('res://unittest.gd').run([
        'res://testing_sample.gd',
    ])
    quit()