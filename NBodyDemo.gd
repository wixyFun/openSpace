extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Camera.look_at_from_position(Vector3(0,0,100), Vector3(0,0,0), Vector3(0,0,1))
	$NBody.init(2.95912208286e-4)
	$NBody.addPlanet(1.00000597682, 0,0,0,0,0,0)
	$NBody.addPlanet(0.000954786104043,-3.5023653, -3.8169847, -1.5507963,0.00565429 , -0.00412490 , -0.00190589)
	$NBody.addPlanet(0.000285583733151,9.0755314, -3.0458353, -1.6483708,0.00168318 , 0.00483525 , 0.00192462)
	$NBody.addPlanet(0.0000437273164546, 8.3101420, -16.2901086, -7.2521278, 0.00354178 , 0.00137102 , 0.00055029)
	$NBody.addPlanet(7.692307692307693e-09, -15.5387357, -25.2225594, -3.1902382, 0.00276725 , -0.00170702 , -0.00136504)
	$NBody.setTimeScale(5000.0)
	$NBody.unPause()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
