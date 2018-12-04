func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Camera.look_at_from_position(Vector3(0,0,100), Vector3(0,0,0), Vector3(0,0,1))
	$NBody.init(2.95912208286e-4)
	$NBody.addPlanet(1.00000597682, 2,3,4,5,6,4)
	$NBody.addPlanet(0.000954786104043,-3.5023653, -3.8169847, -1.5507963,0.00565429 , -0.00412490 , -0.00190589)
	self.add_planets()
	
	$NBody.setTimeScale(5000.0)
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