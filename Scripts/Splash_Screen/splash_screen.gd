extends Node2D

func _on_animation_finished(_anim_name):
	Loading.fade_load_scene(self, "res://Scenes/menu/menu.tscn")
