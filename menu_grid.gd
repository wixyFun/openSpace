extends GridContainer

# class member variables go here, for example:
var grid_theme = Theme.new()
var button_template = preload("Main_button.gd")
var new_game_button
var prev_game_button
var exit_button
var play_button
var add_button


func _ready():
	
	self.columns = 1
	self.set_theme(grid_theme)
	grid_theme.set_constant("vseparation", "GridContainer", 50)
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
func get_start_ready():
	
	new_game_button = button_template.new()
	new_game_button.text = "Play New Game"
	
	
	prev_game_button = button_template.new()
	prev_game_button.text = "Load Previous Game"
	
	
	exit_button = button_template.new()
	exit_button.text = "Exit Game"
	
	self.add_child(new_game_button)
	self.add_child(prev_game_button)
	self.add_child(exit_button)
	
	pass
	
func set_start_controls():
	
	exit_button.connect("pressed", self, "exit_pressed")
	new_game_button.connect("pressed", self, "set_new_game")
	
	pass
	
func exit_pressed():
	
	self.get_tree().quit()
	
	pass
	
func set_new_game():
	
	self.remove_from_grid([exit_button,prev_game_button,new_game_button])
	
	self.get_main_ready()
	
	pass
	
func remove_from_grid(list):
	
	for child in list:
		self.remove_child(child)
	
	pass
	
func get_main_ready():
	
	self.columns = 2
	
	play_button = button_template.new()
	play_button.text = "Play"
	
	add_button = button_template.new()
	add_button.text = "Play New Game"
	
	exit_button = button_template.new()
	exit_button.text = "Play New Game"
	
	
	
	
	
	
	
	
	

	pass
