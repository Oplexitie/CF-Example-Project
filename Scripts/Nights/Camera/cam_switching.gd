extends Node2D

var curr_cam : int = 0
# rooms_array = [room1[character1,character2],room2[empty,empty]]
# 0=empty 1=character other=special_character_pose
var rooms_array : Array = [
	#Room 1 (Candy and Cindy start)
	[1,1,0,0,0,0],
	#Room 2
	[0,0,0,0,0,0],
	#Room 3
	[0,0,0,0,0,0],
	#Room 4
	[0,0,0,0,0,0],
	#Room 5
	[0,0,0,0,0,0],
	#Room 6
	[0,0,0,0,0,0],
	#Room 7
	[0,0,0,0,0,0],
	#Room 8
	[0,0,0,0,0,0],
	#Room 9
	[0,0,0,0,0,0],
	#Room 10
	[0,0,0,0,0,0],
	#Room 11
	[0,0,0,0,0,1],
	#Room 12
	[0,0,0,0,0,0],
	#Void Room (A place where characters with no visible start point live),
	#Chester, Penguin and Old Candy start
	[0,0,1,1,1,0],
	#Inside the office
	[0,0,0,0,0,0]]
var cam_room_array : Array = []
var cam_button_array : Array = []

onready var animtree = $"../AnimationTree"
onready var tree_state_machine = animtree["parameters/StaticState/playback"]

func _ready():
	var cam_rooms = $Cam_Rooms
	var cam_buttons = $Cam_Buttons
	
	# Adds the camera images and buttons into seperate arrays so they can be synced
	# up in the '_on_click_cam' function
	for i in cam_rooms.get_children():
		cam_room_array.append(i)
	for i in cam_buttons.get_children():
		cam_button_array.append(i)
	cam_button_array[0].disabled = true
	update_rooms([0,1,2,3,4,5,6,7,8,9,10,11])

func _on_click_cam(extra_arg_0 : int):
	# This function handles switching cameras, while preventing the player from
	# spamming the same camera and getting the same switching animation
	if curr_cam != extra_arg_0:
		Audio.playsfx(2, preload("res://Audio/Camera_Change.ogg"),0.75)
		tree_state_machine.start("static_boot")
		
		cam_room_array[curr_cam].visible = false
		cam_button_array[curr_cam].disabled = false
		
		cam_room_array[extra_arg_0].visible = true
		cam_button_array[extra_arg_0].disabled = true
		
		curr_cam = extra_arg_0

func _on_gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		tree_state_machine.start("static_boot")
		if Global.is_vision_on == false:
			Audio.playsfx(3, preload("res://Audio/Night_Vision.ogg"),0.25)
			Global.batt_usage += 1
		else:
			Audio.playsfx(3, preload("res://Audio/Night_Vision_OFF.ogg"),0.25)
			Global.batt_usage -= 1
		Global.is_vision_on = !Global.is_vision_on
		update_rooms([0,1,2,3,4,5,6,7,8,9,10,11])

func update_rooms(rooms_to_update : Array):
	# (1) This function handles the room states based on the room array's, that's modified,
	# by the 'ai_move' function
	# (2) You can use an 'AnimatedSprite' instead of a 'Sprite' node, to handle animations,
	# although you'll need to switch animation to switch between states
	for i in rooms_to_update:
		match i:
			0:
				#REMINDER [Candy,Cindy]
				match rooms_array[0]:
					[1,1,0,0,0,0]:
						cam_room_array[0].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,0,0,0,0]:
						cam_room_array[0].frame_coords = Vector2(Global.is_vision_on, 0)
					[0,1,0,0,0,0]:
						cam_room_array[0].frame_coords = Vector2(Global.is_vision_on, 3)
					[1,0,0,0,0,0]:
						cam_room_array[0].frame_coords = Vector2(Global.is_vision_on, 2)
			1:
				match rooms_array[1]:
					[0,0,0,0,0,0]:
						cam_room_array[1].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[1].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,1,0,0,0,0]:
						cam_room_array[1].frame_coords = Vector2(Global.is_vision_on, 2)
			2:
				match rooms_array[2]:
					[0,0,0,0,0,0]:
						cam_room_array[2].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[2].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,1,0,0,0,0]:
						cam_room_array[2].frame_coords = Vector2(Global.is_vision_on, 2)
			3:
				match rooms_array[3]:
					[0,0,0,0,0,0]:
						cam_room_array[3].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[3].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,1,0,0,0,0]:
						cam_room_array[3].frame_coords = Vector2(Global.is_vision_on, 2)
			4:
				match rooms_array[4]:
					[0,0,0,0,0,0]:
						cam_room_array[4].stop()
						cam_room_array[4].animation = "default"
						cam_room_array[4].frame = int(Global.is_vision_on)
					[1,0,0,0,0,0]:
						cam_room_array[4].stop()
						cam_room_array[4].animation = "candy"
						cam_room_array[4].frame = int(Global.is_vision_on)
					[0,1,0,0,0,0]:
						cam_room_array[4].stop()
						cam_room_array[4].animation = "cindy"
						cam_room_array[4].frame = int(Global.is_vision_on)
					[0,0,0,0,0,1]:
						cam_room_array[4].stop()
						cam_room_array[4].animation = "blanck_strike"
						cam_room_array[4].frame = int(Global.is_vision_on)
			5:
				match rooms_array[5]:
					[0,0,0,0,0,0]:
						cam_room_array[5].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[5].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,1,0,0,0]:
						cam_room_array[5].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,0,1,0,0]:
						cam_room_array[5].frame_coords = Vector2(Global.is_vision_on, 3)
			6:
				match rooms_array[6]:
					[0,0,0,0,0,0]:
						cam_room_array[6].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[6].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,1,0,0,0]:
						cam_room_array[6].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,0,1,0,0]:
						cam_room_array[6].frame_coords = Vector2(Global.is_vision_on, 3)
			7:
				match rooms_array[7]:
					[0,0,0,0,0,0]:
						cam_room_array[7].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[7].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,1,0,0,0]:
						cam_room_array[7].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,0,1,0,0]:
						cam_room_array[7].frame_coords = Vector2(Global.is_vision_on, 3)
			8:
				match rooms_array[8]:
					[0,0,0,0,0,0]:
						cam_room_array[8].frame_coords = Vector2(Global.is_vision_on, 0)
					[1,0,0,0,0,0]:
						cam_room_array[8].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,1,0,0,0]:
						cam_room_array[8].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,2,0,0,0]:
						cam_room_array[8].frame_coords = Vector2(int(Global.is_vision_on)+2, 2)
					[0,0,0,1,0,0]:
						cam_room_array[8].frame_coords = Vector2(Global.is_vision_on, 3)
			9:
				match rooms_array[9]:
					[0,0,0,0,0,0]:
						cam_room_array[9].frame_coords = Vector2(Global.is_vision_on, 0)
					[0,0,0,1,0,0]:
						cam_room_array[9].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,0,2,0,0]:
						cam_room_array[9].frame_coords = Vector2(Global.is_vision_on, 1)
			10:
				match rooms_array[10]:
					[0,0,0,0,0,0]:
						cam_room_array[10].frame_coords = Vector2(Global.is_vision_on, 0)
					[0,0,0,0,0,1]:
						cam_room_array[10].frame_coords = Vector2(Global.is_vision_on, 1)
					[0,0,0,0,0,2]:
						cam_room_array[10].frame_coords = Vector2(Global.is_vision_on, 2)
					[0,0,0,0,0,3]:
						cam_room_array[10].frame_coords = Vector2(Global.is_vision_on, 3)
			11:
				match rooms_array[11]:
					[0,0,0,0,0,0]:
						cam_room_array[11].frame_coords = Vector2(Global.is_vision_on, 0)
					[0,1,0,0,0,0]:
						cam_room_array[11].frame_coords = Vector2(Global.is_vision_on, 1)
