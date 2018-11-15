extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pause = false

var arrayPlanets = []

onready var planet = preload("res://Planet.tscn")
func _ready():

	$NBodyPhysics.init(2.95912208286e-4)
	# This is a test
	addPlanet(1, 0,0,0, 0,0,0)

func _process(delta):
	
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if (!pause):
		$NBodyPhysics.step(delta)
		updateTranslation()

func addPlanet(m, x, y, z, vx, vy, vz):
	$NBodyPhysics.addBody(m,x,y,z,vx,vy,vz)
	arrayPlanets.push_back(planet.instance())
	arrayPlanets.back().translation = Vector3(x,y,z)
	add_child(arrayPlanets.back())
	
func updateTranslation():
	pass