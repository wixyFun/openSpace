extends Node

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Camera.look_at_from_position(Vector3(0,0,100), Vector3(0,0,0), Vector3(0,0,1))
	$NBody.init(2.95912208286e-4)
	self.add_planets()
	
	$NBody.setTimeScale(10)
	$NBody.unPause()
	
func add_planets():
	
	var planets_data = Global.planets_data
	
	for i in range(planets_data.size()):
		var mass = planets_data[i][0]
		var X = planets_data[i][1]
		var Y = planets_data[i][2]
		var Z = planets_data[i][3]
		var Vx = planets_data[i][4]
		var Vy = planets_data[i][5]
		var Vz = planets_data[i][6]
		
		$NBody.addPlanet(mass, X, Y, Z, Vx, Vy, Vz)
		
	
	pass