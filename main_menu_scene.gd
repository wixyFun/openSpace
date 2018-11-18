extends Node2D

# class member variables go here, for example:
var center_container
var grid = preload("res://menu_grid.gd").new()


func _ready():
	# Called when the node is added to the scene for the first time.
	get_container_ready()
	grid.get_start_ready()
	grid.set_start_controls()
	add_child(center_container)
	center_container.add_child(grid)
	
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func get_container_ready():
	
	center_container = CenterContainer.new()
	center_container.use_top_left = true
	center_container.set_margin( MARGIN_BOTTOM, 200)
	center_container.set_margin( MARGIN_RIGHT, 200)
	center_container.set_margin(MARGIN_TOP, 200)
	center_container.set_margin(MARGIN_LEFT, 200)
	
	
	
	pass
		
func get_main_menu_ready():
	
	pass
	
	
	