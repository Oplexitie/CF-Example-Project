extends Sprite

signal _powerout()

export var path_office_dark : NodePath

onready var batt_timer = $BatterieTimer
onready var office_dark = get_node(path_office_dark)

func _on_BatterieTimer_timeout():
	Global.batterie_left -= Global.batt_usage
	print(Global.batt_usage)
	print(Global.batterie_left)
	
	if Global.batterie_left < 0:
		_prepare_powerout()
	elif Global.batterie_left < 25:
		frame = 4
	elif Global.batterie_left < 125:
		frame = 3
	elif Global.batterie_left < 250:
		frame = 2
	elif Global.batterie_left < 375:
		frame = 1

func _prepare_powerout():
	batt_timer.stop()
	office_dark.visible = true
	
	Audio.stopall()
	Audio.playsfx(1, preload("res://Audio/Powerdown.ogg"), 1.0)
	
	emit_signal("_powerout")
