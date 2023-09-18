extends Node2D

export var office_buttons : Array
export var office_doors : Array

export var fdsf : Resource

func _ready():
	# Setups all the buttons and doors inside the exports
	var index = 0
	for i in office_buttons:
		office_buttons[index] = get_node(i)
		index += 1
	
	index = 0
	for g in office_doors:
		office_doors[index] = get_node(g)
		index += 1
	
	# Using the index of the last setup, setup the button states
	for n in index:
		Global.office_butt_state.append(false)

func _on_clickbutton_event(_viewport, event, _shape_idx, which_button):
	if event.is_action_pressed("leftclick"):
		if Global.can_move == true:
			Audio.playsfx(7, preload("res://Audio/Door_Close.ogg"), 0.5)
			Global.office_butt_state[which_button] = !Global.office_butt_state[which_button]
			office_buttons[which_button].frame_coords.y = int(Global.office_butt_state[which_button])
			office_doors[which_button].play("default", !Global.office_butt_state[which_button])
			
			if Global.office_butt_state[which_button] == true:
				Global.batt_usage += 1
			elif Global.office_butt_state[which_button] == false:
				Global.batt_usage -= 1
