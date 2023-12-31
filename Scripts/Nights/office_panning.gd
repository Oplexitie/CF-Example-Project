extends Sprite

# An export made for objects that need a slight offset due to the equirectangular shader
# [NodePath, PanOffset(int), SpeedClamp(int), SizeClamp(int)]
# In this case it's [Office_Elements/Office_Doors/middledoorbutt/Area2D, 5, 40, 96]
export var list_offset_corrections : Array

var border_distance : Vector2
var mouse_position : Vector2
var pan_value : float
var office_butt_state : Array = [ false, false, false ]

func _ready():
	# get the horizontal size of the window
	var view_size_x = get_viewport().size.x
	
	# This calculates the area where the cursor needs to be to move pan the view to the left.
	border_distance.x = view_size_x / 5
	
	# This calculates the area where the cursor needs to be to move pan the view to the right.
	# The border correcter is made to (kinda) fix the fact that the cursor can't go all the
	# way to the right by 1 pixel.
	var border_correcter = 1/(1920/view_size_x)
	border_distance.y = view_size_x - (border_distance.x + border_correcter)
	
	# Uses the nodepath within the exported array to use the actual object
	for i in list_offset_corrections:
		i[0] = get_node(i[0])

func _physics_process(delta):
	mouse_position = get_viewport().get_mouse_position()
	
	# Checks if the mouse is within one the mouse movement areas, and pans the office if is
	if mouse_position.x < border_distance.x:
		pan_value = (border_distance.x - mouse_position.x) * int(Global.can_move) * 5
	elif mouse_position.x > border_distance.y:
		pan_value = (border_distance.y - mouse_position.x) * int(Global.can_move) * 5
	else:
		pan_value = 0
	
	# Modifies the position of the office, while clamping it, so the office stays in frame
	position.x = clamp(position.x + clamp(pan_value * delta, -40,40), -480, 480)
	
	# Modifies the buttons collision postion, makes it so the button is pressable with the shader
	_apply_offset(delta)

func _apply_offset(delta):
	for i in list_offset_corrections:
		i[0].position.x = clamp(i[0].position.x  + clamp(pan_value/i[1] * delta, -i[2],i[2]), -i[3], i[3])
