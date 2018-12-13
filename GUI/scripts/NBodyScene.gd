extends Node

var Menu = preload("res://GUI/scripts/main_menu_scene.gd")
var popUp_menu = Menu.new()
var grid = popUp_menu.layout

var data_labels =["Enter Name","Enter Mass","Enter Radius", "Enter x ", "Enter y ", "Enter z ", "Enter Vx ", "Enter Vy ", "Enter Vz "]
var buttons_list = ["Add","Simulate","Save", "Exit"]


func _ready():
	
	self.get_plus_ready()
	
	#TODO: separate speed widget
	self.set_speed_buttons()
	popUp_menu.set_lists(buttons_list,data_labels)
	popUp_menu.ready_menu()
	self.get_popUp_ready()
	
	print(popUp_menu.layout.data_grid.get_children())
	
	$Camera.look_at_from_position(Vector3(0,0,100), Vector3(0,0,0), Vector3(0,0,1))
	$NBody.init(2.95912208286e-4)
	
	
	#$NBody.setTimeScale(10)
	#$NBody.unPause()



func Simulate_pressed():
	
	#check if there are planets to simulate
	if Global.planets_data.size() == 0 :
		popUp_menu.message_box.update_message("Enter Data for Planet/s First", Color(1,0,0))
	else:
		$PopupPanel.hide()
		self.add_planets()
	pass
	
func get_plus_ready():
		
	grid.controls.get_button_controls(["+"])
	grid.controls_dict["+"].set_position(Vector2(20,20))
	
	self.add_child(grid.controls_dict["+"])
	grid.controls_dict["+"].connect("pressed", self, "display_menu")
	
	pass
	
func set_speed_buttons():
	var window = OS.window_size
	grid.controls.get_button_controls(["slow down", "speed up"])
	self.add_child(grid.controls_dict["speed up"])
	self.add_child(grid.controls_dict["slow down"])
	grid.controls_dict["speed up"].set_position(Vector2(window.x-100,window.y-100))
	grid.controls_dict["slow down"].set_position(Vector2(window.x-200,window.y-100))
	grid.controls_dict["speed up"].connect("pressed", self, "speed_up")
	grid.controls_dict["slow down"].connect("pressed", self, "slow_down")
	
	pass
	
func display_menu():
	$PopupPanel.popup_centered_ratio(0.75)
	#Global.controls_dict["+"].text = "-"
	
	pass
	
func get_popUp_ready():
	$PopupPanel.add_child(popUp_menu)
	
	#get the Simulate ready
	grid.controls_dict["Simulate"].connect("pressed", self, "Simulate_pressed")
	pass
	
func speed_up():
	# Move forward/zoom in
	$Camera.translate(Vector3(0,0,-10))

	
func slow_down():
	$Camera.translate(Vector3(0,0,10))

	
func add_planets():
	
	var planets_data = Global.planets_data
	
	for i in range(planets_data.size()):
		var planets_name = planets_data[i][0]
		var mass = planets_data[i][1]
		var radius = planets_data[i][2]
		var X = planets_data[i][3]
		var Y = planets_data[i][4]
		var Z = planets_data[i][5]
		var Vx = planets_data[i][6]
		var Vy = planets_data[i][7]
		var Vz = planets_data[i][8]
		
		$NBody.addPlanet(mass, X, Y, Z, Vx, Vy, Vz)
		#TODO: change the color of the planet, radius, have a legend nnext to the planet
	
	pass