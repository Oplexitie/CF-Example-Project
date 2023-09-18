extends Node

onready var loading_scene = preload("res://Scenes/loading/loading.tscn")

func _ready():
	self.set_pause_mode(2) # Set pause mode to Process

func load_scene(current_scene, next_scene):
	# add loading scene to the root
	var loading_scene_instance = loading_scene.instance()
	get_tree().get_root().call_deferred("add_child",loading_scene_instance)
	
	# find the targeted scene
	var loader = ResourceLoader.load_interactive(next_scene)
	
	#check for errors
	if loader == null:
		# handle your error
		print("error occured while getting the scene")
		return

	current_scene.queue_free()
	# creating a little delay, that lets the loading screen to appear.
	yield(get_tree().create_timer(0.5),"timeout")

	# loading the next_scene using poll() function
	# since poll() function loads data in chunks thus we need to put that in loop
	while true:
		var error = loader.poll()
		# when we get a chunk of data
		if error == OK:
			pass
		# when all the data have been loaded
		elif error == ERR_FILE_EOF:
			# creating scene instance from loaded data
			var scene = loader.get_resource().instance()
			# adding scene to the root
			get_tree().get_root().call_deferred("add_child",scene)
			# removing loading scene
			loading_scene_instance.queue_free()
			return
		else:
			# handle your error
			print('error occurred while loading chunks of data')
			return

func fade_load_scene(current_scene, next_scene):
	# add loading scene to the root
	var loading_scene_instance = load(next_scene).instance()
	get_tree().get_root().call_deferred("add_child",loading_scene_instance)
	
	# prepares the tween for the transition
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(
	current_scene, "modulate:a", 
	1.0, 0.0, 1.0,
	Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()
	
	var tween2 = Tween.new()
	add_child(tween2)
	tween2.interpolate_property(
	loading_scene_instance, "modulate:a", 
	0.0, 1.0, 1.0,
	Tween.TRANS_QUAD, Tween.EASE_IN)
	tween2.start()
	
	# gets rid of all the stuff we don't need anymore
	tween.connect("tween_all_completed",tween,"queue_free")
	tween.connect("tween_all_completed",current_scene,"queue_free")
	tween2.connect("tween_all_completed",tween2,"queue_free")
