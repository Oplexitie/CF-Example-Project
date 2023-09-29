extends Sprite

signal _powerout()

export var path_office_dark : NodePath
export var num_battery_bars : int

var max_battery : int
var batt_visual_calc : int

onready var batt_timer = $BatterieTimer
onready var office_dark = get_node(path_office_dark)

func _ready():
	max_battery = Global.batterie_left
	batt_visual_calc = (max_battery+((max_battery/num_battery_bars)/5))-(max_battery/num_battery_bars)*(frame+1)
	print(batt_visual_calc)

func _on_BatterieTimer_timeout():
	Global.batterie_left -= Global.batt_usage
	print(Global.batt_usage)
	print(Global.batterie_left)
	
	if Global.batterie_left < 0:
		_prepare_powerout()
		return
		
	if Global.batterie_left < batt_visual_calc:
		frame += 1
		batt_visual_calc = (max_battery+((max_battery/4)/5))-(max_battery/4)*(frame+1)

func _prepare_powerout():
	batt_timer.stop()
	office_dark.visible = true
	
	Audio.stopall()
	Audio.playsfx(1, preload("res://Audio/Powerdown.ogg"), 1.0)
	
	emit_signal("_powerout")
