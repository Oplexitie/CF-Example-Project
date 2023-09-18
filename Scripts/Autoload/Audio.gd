extends Node

const num_players = 8
var audioplayers = []

func _ready():
	self.set_pause_mode(2) # Set pause mode to Process
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		audioplayers.append(p)
		match i:
			0: p.bus = "Music"
			1,2,3: p.bus = "SFX1"
			4,5,6: p.bus = "SFX2"
	#Added this to avoid hear rapes, already happened 2 times :(
	AudioServer.set_bus_volume_db(0,-10)

# s_playid -> 0 (Music), 1 (Jumpscare), 2 (CameraChange), 3 (CameraBlip), 4 (Doors), 5 (DoorBlips), 6 (Panel), 7(glass)
#this is for sound effects
func playsfx(s_playid: int, stream: AudioStreamOGGVorbis, volume: float = 1.0):
	audioplayers[s_playid].set_volume_db(linear2db(volume))
	audioplayers[s_playid].stream = stream

	audioplayers[s_playid].play()

#this is for the music
func playmusic(stream: AudioStreamOGGVorbis):
	audioplayers[0].stream = stream
	audioplayers[0].play()

#this is to fade out/in the music
func fademusic(s_from: float, s_to: float, duration: float):
	var tween = Tween.new()
	add_child(tween)
	#when tween is done, delete the tween
	tween.connect("tween_all_completed", tween, "queue_free")
	tween.interpolate_property(audioplayers[0], "volume_db", s_from, s_to, duration, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()

#stop one audioplayer
func stop(s_playid: int):
	audioplayers[s_playid].stop()

#stop all the audioplayers
func stopall():
	for i in num_players:
		audioplayers[i].stop()
		
func bus_muting(busid: int, ismute: bool):
	AudioServer.set_bus_mute(busid, ismute)
