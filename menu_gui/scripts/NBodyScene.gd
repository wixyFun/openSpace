extends Node

var Menu = preload("res://menu_gui/scripts/main_menu_scene.gd")
var popUp_menu = Menu.new()

var data_labels =["Enter Name","Enter Mass","Enter Radius", "Enter x ", "Enter y ", "Enter z ", "Enter Vx ", "Enter Vy ", "Enter Vz "]
var buttons_list = ["Add", "Simulate", "Save", "Exit"]


func _ready():
	
	self.get_plus_ready()
	self.set_speed_buttons()
	self.get_popUp_menu()
	
	popUp_menu.set_lists(buttons_list,data_labels)
	popUp_menu.ready_menu()
	Global.controls_dict["Simulate"].connect("pressed", self, "Simulate_pressed")
	

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
		
	Global.get_button_controls(["MENU"])
	Global.controls_dict["MENU"].set_position(Vector2(20,20))
	
	self.add_child(Global.controls_dict["MENU"])
	Global.controls_dict["MENU"].connect("pressed", self, "display_menu")
	
	pass
	
func set_speed_buttons():
	
	Global.get_button_controls(["+", "-"])
	self.add_child(Global.controls_dict["+"])
	self.add_child(Global.controls_dict["-"])
	Global.controls_dict["+"].set_position(Vector2(20,40))
	Global.controls_dict["-"].set_position(Vector2(20,60))
	Global.controls_dict["+"].connect("pressed", self, "speed_up")
	Global.controls_dict["-"].connect("pressed", self, "slow_down")
	
	pass
	
func display_menu():
	$PopupPanel.popup_centered_ratio(0.75)
	#Global.controls_dict["+"].text = "-"
	
	pass
	
func get_popUp_menu():
	
	$PopupPanel.add_child(popUp_menu)
	
	pass
	
func speed_up():
	
	pass
	
func slow_down():
	
	pass
	
func add_planets():
	
	var planets_data = Global.planets_data
	
	for i in range(planets_data.size()):
		var name = planets_data[i][0]
		var mass = planets_data[i][1]
		var radius = planets_data[i][2]
		var X = planets_data[i][3]
		var Y = planets_data[i][4]
		var Z = planets_data[i][5]
		var Vx = planets_data[i][6]
		var Vy = planets_data[i][7]
		var Vz = planets_data[i][8]
		
		$NBody.addPlanet(mass, X, Y, Z, Vx, Vy, Vz)
		
	
	pass