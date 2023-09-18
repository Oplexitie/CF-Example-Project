extends Sprite

onready var clocktimer = $ClockTimer

func _on_ClockTimer_timeout():
	Global.clock_hour += 1
	if Global.clock_hour < 6:
		frame = Global.clock_hour
	else:
		clocktimer.stop()
		Global.can_move = false
		Loading.fade_load_scene($"../../../Nights", "res://Scenes/night/6am.tscn")
		get_tree().paused = true
