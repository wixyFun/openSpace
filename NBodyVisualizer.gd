extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pause = false

var arrayPlanets = []
onready var planet = preload("res://Planet.tscn")
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	var p = planet.instance()
	add_child(p)
	p = planet.instance()
	p.translation = Vector3(1,0,0)
	add_child(p)

	#$NBodyPhysics.init(2.95912208286e-4)
	# This is a test
	#addPlanet(1, 0,0,0, 0,0,0)

func _process(delta):
	pass
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	if (!pause):
#		$NBodyPhysics.step(delta)
		#visualize()

func addPlanet(m, x, y, z, vx, vy, vz):
	$NBodyPhysics.addBody(m,x,y,z,vx,vy,vz)
	arrayPlanets.push_back(load("res://Planet.tscn"))
	
func visualize():
	pass