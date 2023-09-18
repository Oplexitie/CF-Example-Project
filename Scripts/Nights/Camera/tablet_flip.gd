extends Node2D

export var path_cam_stuff : NodePath

var is_tablet_up : bool = false

onready var tablet_button = $Tablet_Button/Button
onready var tweener = $Tween
onready var tablet_sprite = $Tablet_Animation
onready var cam_stuff = get_node(path_cam_stuff)

func on_mouse_enter():
	tweener.interpolate_property(tablet_button, "modulate:a", tablet_button.modulate.a, 0.75, 0.3,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweener.start()

func on_mouse_exit():
	tweener.interpolate_property(tablet_button, "modulate:a", tablet_button.modulate.a, 0.29, 0.3,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweener.start()

func _on_click():
	# This function handles if the tablet should be played or not when the button is pressed
	if is_tablet_up == false:
		tablet_sprite.visible = true
		tablet_sprite.play("lift",false)
		Global.can_move = false
	else:
		Global.batt_usage -= 1 + int(Global.is_vision_on)
		tablet_sprite.play("lift",true)
		tablet_button.disabled = true
		cam_stuff.visible = false
	Audio.playsfx(6, preload("res://Audio/Panel.ogg"),0.4)

func _tablet_animation_finished():
	# This function handles the nodes that should be active or not, when the tablet is up or down
	# also handles them when there's jumpscares
	if is_tablet_up == false:
		Global.batt_usage += 1 + int(Global.is_vision_on)
		is_tablet_up = !Global.is_jumpscare
		cam_stuff.visible = !Global.is_jumpscare
		tablet_sprite.visible = !Global.is_jumpscare
		cam_stuff.tree_state_machine.start("static_boot")
		Audio.playsfx(2, preload("res://Audio/Camera_Change.ogg"),int(!Global.is_jumpscare)*0.75)
	else:
		is_tablet_up = false
		tablet_sprite.visible = false
		Global.can_move = !Global.is_jumpscare
		tablet_button.disabled = false
