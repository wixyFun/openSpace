extends ScrollContainer

var hBar
var vBar



func _ready():

	scroll_vertical_enabled = true
	hBar = get_child(0)
	vBar - get_child(1)

	#h_bar.connect("value_changed", self, "h_change")
    #v_bar.connect("value_changed", self, "v_change")

func h_change(val):
    print(val)

func v_change(val):
    print(val)