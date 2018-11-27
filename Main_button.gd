"""
class for uniform design of the buttons in the game
TODO: set the theme and the size, methods for updating/setting those
"""


extends Button

# class member variables go here, for example:



func _init():  

	self.text = "Change My Text"

	set_process(true)
	

	pass
	
func _process(delta):
	
	#set_size(Vector2 (100, 50))
	set_scale (Vector2(1.5, 1.5))
	
	pass
	

	

