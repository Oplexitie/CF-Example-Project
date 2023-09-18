extends Node2D

signal play_jumpscare(character)
signal blank_breakwindow()

var char_levels : Array = [0,0,0,0,0,0]		# Character levels [character1,character2]
var char_pos : Array = [0,0,0,0,0,0]	# Character positions [character1,character2]
var blank_has_played : bool = false
var skip_blank_look : bool = false

onready var cam_elements : Node2D = $"../Camera_Elements"
onready var chara_eyes : Array = [
	$"../../Office_Elements/eyes1",
	$"../../Office_Elements/eyes2",
	$"../../Office_Elements/eyes3"
]

onready var chara_timer : Array = [ 
	$CandyTimer,
	$CindyTimer,
	$ChesterTimer,
	$OldCTimer,
	$BlankTimer
 ]

func _ready():
	char_levels = Global.character_levels
	randomize()

func _physics_process(_delta):
	if cam_elements.cam_room_array[4].visible == true and cam_elements.cam_room_array[4].frame == 1:
		if char_pos[5] == 3:
			cam_elements.cam_room_array[4].frame = 1
			cam_elements.cam_room_array[4].play()
			blank_has_played = true

func _char_timer_timeout(extra_arg_0 : int):
	# This function triggers when one of the character timers is done, and handles
	# everything related to character movement
	if (char_levels[extra_arg_0] >= randi()%20+1):
		char_pos[extra_arg_0] +=1
		update_ai_pos(extra_arg_0)

func update_ai_pos(animatronic : int):
	# This function updates the characters position based on the 'char_pos' value
	match animatronic:
		0:
			match char_pos[0]:
				1:
					ai_move(0,1,0)
				2:
					if (randi()%2 != 0):
						ai_move(1,4,0)
					else:
						ai_move(1,8,0)
						char_pos[0] = 8					
				3: 
					ai_move(4,2,0)
				4:
					# In front of right office door
					chara_timer[0].stop()
					ai_move(2,3,0)
					chara_eyes[0].visible = true
					yield(get_tree().create_timer(6.0), "timeout")
					char_pos[0] +=1
					update_ai_pos(0)
				5:
					if(Global.office_butt_state[1]==true):
						# Bonks against the door
						char_pos[0] = 0
						ai_move(3,0,0,false)
						chara_timer[0].stop()
						chara_timer[0].start(3.02)
						chara_eyes[0].visible = false
					else:
						# If empty enters the office
						if cam_elements.rooms_array[13]==[0,0,0,0,0,0]:
							ai_move(3,13,0)
							char_pos[0] +=1
							update_ai_pos(0)
							chara_eyes[0].visible = false
				6:
					yield(get_tree().create_timer(3 + randi()%4), "timeout")
					emit_signal("play_jumpscare", "candy")
				9:
					ai_move(8,7,0)
				10:
					ai_move(7,6,0)
				11:
					# In front of left office door
					chara_timer[0].stop()
					ai_move(6,5,0)
					chara_eyes[1].visible = true
					yield(get_tree().create_timer(6.0), "timeout")
					char_pos[0] +=1
					update_ai_pos(0)
				12:
					# Bonks against the door
					if(Global.office_butt_state[0]==true):
						char_pos[0] = 0
						ai_move(5,0,0,false)
						chara_timer[0].stop()
						chara_timer[0].start(3.02)
						chara_eyes[1].visible = false
					else:
						# If empty enters the office
						if cam_elements.rooms_array[13]==[0,0,0,0,0,0]:
							ai_move(5,13,0)
							char_pos[0] +=1
							update_ai_pos(0)
							chara_eyes[1].visible = false
				13:
					yield(get_tree().create_timer(3 + randi()%4), "timeout")
					emit_signal("play_jumpscare", "candy")
		1:
			match char_pos[1]:
				1:
					ai_move(0,11,1)
				2:
					ai_move(11,1,1)
				3:
					ai_move(1,4 ,1)
				4:
					ai_move(4,2,1)
				5:
					# In front of right office door
					chara_timer[1].stop()
					ai_move(2,3,1)
					chara_eyes[0].visible = true
					yield(get_tree().create_timer(6.0), "timeout")
					char_pos[1] +=1
					update_ai_pos(1)
				6:
					if(Global.office_butt_state[1]==true):
						#Bonks against the door
						char_pos[1] = 0
						ai_move(3,0,1,false)
						chara_timer[1].stop()
						chara_timer[1].start(4.97)
						chara_eyes[0].visible = false
					else:
						# If empty enters the office
						if cam_elements.rooms_array[13]==[0,0,0,0,0,0]:
							ai_move(3,13,1)
							char_pos[1] +=1
							update_ai_pos(1)
							chara_eyes[0].visible = false
				7: 
					yield(get_tree().create_timer(3 + randi()%4), "timeout")
					emit_signal("play_jumpscare", "cindy")
		2:
			match char_pos[2]:
				1:
					ai_move(12,8,2)
				2:
					ai_move(8,8,2,false,2)
				3:
					ai_move(8,7,2)
				4:	
					ai_move(7,6,2)
				5:	
					# In front of left office door
					chara_timer[2].stop()
					ai_move(6,5,2)
					chara_eyes[1].visible = true
					yield(get_tree().create_timer(6.0), "timeout")
					char_pos[2] +=1
					update_ai_pos(2)
				6:
					# Bonks against the door
					if(Global.office_butt_state[0]==true):
						char_pos[2] = 0
						ai_move(5,12,2,false)
						chara_timer[2].stop()
						chara_timer[2].start(3.72)
						chara_eyes[1].visible = false
					else:
						# If empty enters the office
						if cam_elements.rooms_array[13]==[0,0,0,0,0,0]:
							ai_move(5,13,2)
							char_pos[2] +=1
							update_ai_pos(2)
							chara_eyes[1].visible = false
				7:
					yield(get_tree().create_timer(3 + randi()%4), "timeout")
					emit_signal("play_jumpscare", "chester")
		3:
			match char_pos[3]:
				1:
					ai_move(12,9,3,false, 1)
				2:
					ai_move(9,9,3,false, 2)
				3:
					ai_move(9,8,3)
				4:
					ai_move(8,7,3)
				5:
					ai_move(7,6,3)
				6:
					# In front of left office door
					ai_move(6,5,3)
					chara_timer[3].stop()
					yield(get_tree().create_timer(6.0), "timeout")
					char_pos[3] +=1
					update_ai_pos(3)
				7:
					# Bonks against the door
					if(Global.office_butt_state[0]==true):
						char_pos[3] = 0
						ai_move(5,12,3,false)
						chara_timer[3].stop()
						chara_timer[3].start(4.21)
					else:
						# If empty enters the office
						if cam_elements.rooms_array[13]==[0,0,0,0,0,0]:
							ai_move(5,13,3)
							char_pos[3] +=1
							update_ai_pos(3)
				8:
					yield(get_tree().create_timer(3 + randi()%4), "timeout")
					emit_signal("play_jumpscare", "old")
		5:
			if skip_blank_look == false:
				if cam_elements.cam_room_array[10].visible == true and cam_elements.is_ligh_on == true:
					if (randi()%2 == 0):
						char_pos[5] -=1
						return
			match char_pos[5]:
				1:
					ai_move(10,10,5,false, 2)
				2:
					ai_move(10,10,5,false, 3)
				3:
					ai_move(10,4,5)
					chara_timer[4].stop()
					skip_blank_look = true
					yield(get_tree().create_timer(5.0), "timeout")
					char_pos[5] +=1
					update_ai_pos(5)
				4:
					if(Global.office_butt_state[2]==true):
						Audio.playsfx(7, preload("res://Audio/Glass_Impact.ogg"))
						char_pos[5] = 0
						ai_move(4,10,5)
						chara_timer[4].stop()
						chara_timer[4].start(5.86)
						skip_blank_look = false
					else:
						if blank_has_played == false:
							if Global.batterie_left > 0:
								ai_move(4,13,5)
								char_pos[5] +=1
								update_ai_pos(5)
								emit_signal("blank_breakwindow")
				6: 
					ai_move(4,13,5)
	print(str(animatronic) + "'s position is " + str(char_pos[animatronic]))

func ai_move(from_room : int, to_room : int, character : int, checknextroom : bool = true, newstate : int = 1):
	# This function handles the movement from one room to another or changing the characters
	# state in a room (handled by newstate), while also playing the boot_static animation
	# The function also checks if the next room is empty, if it is move to that room
	
	if(checknextroom == true):
		if(cam_elements.rooms_array[to_room]==[0,0,0,0,0,0]):
			pass
		else:
			char_pos[character]-=1
			return
	
	cam_elements.rooms_array[from_room][character]=0
	cam_elements.rooms_array[to_room][character]=newstate
	if cam_elements.curr_cam ==  from_room or cam_elements.curr_cam ==  to_room:
		cam_elements.tree_state_machine.start("static_boot")
		Audio.playsfx(2, preload("res://Audio/Camera_Interrupt.ogg"),int(cam_elements.visible))
	cam_elements.update_rooms([from_room,to_room])
