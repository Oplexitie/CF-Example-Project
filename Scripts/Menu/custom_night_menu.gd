extends Node

onready var levels = [
	0,
	0,
	0,
	0,
	0,
	0
	]
onready var text = [
	$CandyIcon/candylevel,
	$CindyIcon/cindylevel,
	$ChesterIcon/chesterlevel,
	$OldCatIcon/oldlevel,
	"nothin",
	$BlankIcon/blanklevel
	]

func _on_TextureButton_pressed():
	Loading.load_scene(self, "res://Scenes/night/night.tscn")
	Global._reset_night_var()

func _on_levelbutt_pressed(event, extra_arg_0, extra_arg_1):
	if event.is_action_pressed ("leftclick"):
		levels[extra_arg_0]=clamp(levels[extra_arg_0] + extra_arg_1, 0, 20)
		text[extra_arg_0].bbcode_text = "[center]" + str(levels[extra_arg_0]) + "[/center]"
		
		Global.character_levels[extra_arg_0] = levels[extra_arg_0]
