extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pause = true

var initialized = false

var timeScale = 1.0

var arrayPlanets = []

onready var planet = preload("res://Planet.tscn")

#func _ready(G):
#	#$NBodyPhysics.init(2.95912208286e-3)

func _process(delta):
	
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if (initialized && !pause):
		$NBodyPhysics.step(delta * timeScale)
		updateTranslation()

func init(G):
	$NBodyPhysics.init(G)
	initialized = true

func unPause():
	pause = false
	
func pause():
	pause = true
	
func setTimeScale(ts):
	timeScale = ts

func getTimeScale():
	return timeScale
	
func addPlanet(m, x, y, z, vx, vy, vz):
	$NBodyPhysics.addBody(m,x,y,z,vx,vy,vz)
	arrayPlanets.push_back(planet.instance())
	arrayPlanets.back().translation = Vector3(x,y,z)
	add_child(arrayPlanets.back())
	
func updateTranslation():
	var i = 0
	var xs = $NBodyPhysics.getXs()
	for p in arrayPlanets:
		p.translation = xs[i]
		i = i + 1