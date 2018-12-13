extends CenterContainer

var message_label = Label.new()

func _ready():
	self.use_top_left = false

	pass

func get_mbox_ready(message):
	
	message_label.text = message;
	self.add_child(message_label);
	
	pass
	
func update_message(prompt, colored):
	message_label.text = prompt
	message_label.add_color_override("font_color", colored)
	message_label.ALIGN_RIGHT
	message_label.update()
	pass

func set_frame(top,bottom,right,left):
	
	self.set_margin(MARGIN_TOP, top)
	self.set_margin( MARGIN_LEFT, left)
	self.set_margin(MARGIN_BOTTOM, bottom)
	self.set_margin( MARGIN_RIGHT, right)
	
	pass