extends Node2D

func _ready():
	Audio.stopall()
	Audio.playsfx(0, preload("res://Audio/Clock.ogg"), 1)
	
func _on_animation_finished(anim_name):
	match(anim_name):
		"6amplay":
			Loading.load_scene(self, "res://Scenes/menu/menu.tscn")
	get_tree().paused = false
