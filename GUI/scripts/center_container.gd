extends CenterContainer

func _ready():
	self.use_top_left = false
	pass
	
	
func set_sizeTo_screen(scale):
	
	if scale >0:
		self.rect_min_size = OS.window_size*scale
	print(OS.window_size)
	
	pass
	
func set_frame(top,bottom,right, left):
	
	self.set_margin( MARGIN_BOTTOM, bottom)
	self.set_margin( MARGIN_RIGHT, right)
	self.set_margin(MARGIN_TOP, top)
	self.set_margin(MARGIN_LEFT, left)
	
	pass
	
