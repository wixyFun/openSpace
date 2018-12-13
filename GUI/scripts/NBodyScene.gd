extends Node

var Menu = preload("res://GUI/scripts/main_menu_scene.gd")
var popUp_menu = Menu.new()
var grid = popUp_menu.layout

var data_labels =["Enter Name","Enter Mass","Enter Radius", "Enter x ", "Enter y ", "Enter z ", "Enter Vx ", "Enter Vy ", "Enter Vz "]
var buttons_list = ["Add","Simulate","Save", "Exit"]

var camera_focused = false
var G = 2.95912208286e-4
func _ready():
	
	self.get_plus_ready()
	
	#TODO: separate speed widget
	self.set_speed_buttons()
	popUp_menu.set_lists(buttons_list,data_labels)
	popUp_menu.ready_menu()
	self.get_popUp_ready()
	
	print(popUp_menu.layout.data_grid.get_children())
	
	$Camera.look_at_from_position(Vector3(0,0,100), Vector3(0,0,0), Vector3(0,0,1))
	$NBody.init(G)
	
	
	#$NBody.setTimeScale(10)
	#$NBody.unPause()

func _process(delta):
	if camera_focused:
		var vec = Vector3(0,0,0)
		if Input.is_action_pressed("ui_right"):
			vec += Vector3(1, 0, 0)
		if Input.is_action_pressed("ui_left"):
			vec += Vector3(-1, 0, 0)
		if Input.is_action_pressed("ui_up"):
			vec += Vector3(0, 0, -1)
		if Input.is_action_pressed("ui_down"):
			vec += Vector3(0, 0, 1)
		$Camera.translate_object_local(vec.normalized())

func Simulate_pressed():
	
	#check if there are planets to simulate
	if Global.planets_data.size() == 0 :
		popUp_menu.message_box.update_message("Enter Data for Planet/s First", Color(1,0,0))
	else:
		$PopupPanel.hide()
		self.add_planets()
		camera_focused = true
	
func get_plus_ready():
		
	grid.controls.get_button_controls(["+"])
	grid.controls_dict["+"].set_position(Vector2(20,20))
	
	self.add_child(grid.controls_dict["+"])
	grid.controls_dict["+"].connect("pressed", self, "display_menu")
	
func set_speed_buttons():
	var window = OS.window_size
	grid.controls.get_button_controls(["slow down", "speed up"])
	self.add_child(grid.controls_dict["speed up"])
	self.add_child(grid.controls_dict["slow down"])
	grid.controls_dict["speed up"].set_position(Vector2(window.x-100,window.y-100))
	grid.controls_dict["slow down"].set_position(Vector2(window.x-200,window.y-100))
	grid.controls_dict["speed up"].connect("pressed", self, "speed_up")
	grid.controls_dict["slow down"].connect("pressed", self, "slow_down")
	
func display_menu():
	camera_focused = false
	$PopupPanel.popup_centered_ratio(0.75)
	#Global.controls_dict["+"].text = "-"
	
func get_popUp_ready():
	$PopupPanel.add_child(popUp_menu)
	
	#get the Simulate ready
	grid.controls_dict["Simulate"].connect("pressed", self, "Simulate_pressed")
	
func speed_up():
	# Move forward/zoom in
	$Camera.translate(Vector3(0,0,-10))

	
func slow_down():
	$Camera.translate(Vector3(0,0,10))

func set_orbits(planets, orbits):
	for i in range(0, orbits.size()):
		# Get center index
		var j = orbits[i]
		# 
		assert (i != j)
		if j != -1:
			var ix = planets[i][3]
			var iy = planets[i][4]
			var iz = planets[i][5]
			var iX = Vector3(ix,iy,iz)
			var ivx = planets[i][6]
			var ivy = planets[i][7]
			var ivz = planets[i][8]
			var iV = Vector3(ivx,ivy,ivz)
			var jm = planets[j][1]
			var jx = planets[j][3]
			var jy = planets[j][4]
			var jz = planets[j][5]
			var jX = Vector3(jx,jy,jz)
			var jvx = planets[j][6]
			var jvy = planets[j][7]
			var jvz = planets[j][8]
			var jV = Vector3(jvx,jvy,jvz)
			
			var R = jX - iX
			var r = R.length()
			var v = sqrt(G * jm / r) # Orbital speed
			# Same inclination as original velocity
			var n = iV - R.normalized() * (iV.dot(R.normalized()))
			print(n)
			# If original velocity is aligned with _R_,
			# then perpendicular to Z axis
			#n = R.cross(Vector3(0,0,1)) if n.length()==0.0 else n
			if n.length() < 0.001:
				n = n + Vector3(1, 0, 0)
			n = n - R.normalized() * (n.dot(R.normalized()))
			if n.length() < 0.001:
				n = n + Vector3(0, 1, 0)				
			n = n - R.normalized() * (n.dot(R.normalized()))
			# Make sure adjust for j's orbital velocity
			var iV_new = v * n.normalized() + jV
			planets[i][6] = iV_new.x
			planets[i][7] = iV_new.y
			planets[i][8] = iV_new.z
	

	
func add_planets():
	
	var planets_data = Global.planets_data
	var orbits = Global.orbits
	set_orbits(planets_data, orbits)
	
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
		$NBody.setTimeScale(10)
		$NBody.unPause()
		#TODO: change the color of the planet, radius, have a legend nnext to the planet