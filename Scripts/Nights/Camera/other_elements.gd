extends Node2D

onready var tablet_button = $Tablet_Elements/Tablet_Button/Button
onready var tablet_sprite = $Tablet_Elements/Tablet_Animation
onready var cam_stuff = $Camera_Elements
onready var chara_ai = $CharacterAI
onready var jumpscare_anim = $Jumpscares

onready var office_clock : Timer = $"../Office_Elements/officeclock/ClockTimer"
onready var office_dark : AnimatedSprite =  $"../Office_Elements/office_dark"
onready var office_broken : Sprite =  $"../Office_Elements/office_brockenwin"

func _play_jumpscare(character):
	
	office_clock.stop()
	
	Audio.stopall()
	match(character):
		"candy","cindy","chester","powerout":
			Audio.playsfx(1, preload("res://Audio/Jumpscare_Generic.ogg"), 0.5)
		"blank","old":
			Audio.playsfx(1, preload("res://Audio/Jumpscare_Robotic.ogg"), 0.5)
	jumpscare_anim.animation = character

	Global.can_move = false
	tablet_button.visible = false
	Global.is_jumpscare = true
	if tablet_sprite.visible == true:
		cam_stuff.visible = false
		tablet_sprite.play("lift",true)
		
	jumpscare_anim.visible = true
	jumpscare_anim.play()

func _on_Jumpscares_animation_finished():
	yield(get_tree().create_timer(1.0), "timeout")
	Loading.load_scene($"../../Nights", "res://Scenes/menu/menu.tscn")

func _on_room5_animation_finished():
	if Global.batterie_left > 0:
		if(Global.office_butt_state[2]==true):
			Audio.playsfx(7, preload("res://Audio/Glass_Impact.ogg"), 0.5)
			chara_ai.blank_has_played = false
			chara_ai.char_pos[5] = 0
			chara_ai.ai_move(4,10,5)
			chara_ai.chara_timer[4].stop()
			chara_ai.chara_timer[4].start(5.86)
		else:
			Audio.playsfx(7, preload("res://Audio/Glass_Break.ogg"), 0.5)
			office_broken.visible = true
			office_dark.visible = true
			office_dark.play()
			chara_ai.char_pos[5] = 6
			chara_ai.update_ai_pos(5)

func _powerout():
	cam_stuff.rooms_array[13] = [1,0,0,0,0,0]
	
	Global.can_move = false
	tablet_button.visible = false
	Global.is_jumpscare = true
	if tablet_sprite.visible == true:
		cam_stuff.visible = false
		tablet_sprite.play("lift",true)
	
	yield(get_tree().create_timer(8.0), "timeout")
	
	_play_jumpscare("powerout")
