extends Node

var audio:AudioStreamPlayer = AudioStreamPlayer.new()
var fname:String = ""

func seti(f:String):
	
	if fname!=f:
		audio.stop()
		audio.stream = load(f)
		audio.play(0)
		pass
	elif f=="none":
		audio.stop()
	
	
	pass
