extends Node

var character_levels : Array = [0,0,0,0,0,0]

var can_move : bool = true
var clock_hour : int = 0
var batterie_left : int = 500
var batt_usage : int = 0
var is_vision_on : bool = false
var is_jumpscare : bool = false
# This is setup by the office_doors.gd script and can vary in size depending
# on how the script was configured
var office_butt_state : Array = []

func _reset_night_var():
	can_move = true
	clock_hour = 0
	office_butt_state = []
	batterie_left = 500
	batt_usage  = 0
	is_vision_on = false
	is_jumpscare = false
