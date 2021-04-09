extends Node

var audio:AudioStreamPlayer#para la musica
var sound:AudioStreamPlayer#para el sonido
var fname:String = ""

func _ready():
	audio = AudioStreamPlayer.new() #dar la configuracion al motor de musica
	audio.name = "audio"
	add_child(audio)
	audio.bus = "Music"
	
	sound = AudioStreamPlayer.new() #dar la configuracion al motor de sonido
	sound.name = "sound"
	add_child(sound)
	sound.bus = "sounds"
	
	pass

func beat(f:String) -> void:
	
	if f != "none":# si no es none entonces reproducir el sonido
		sound.stop()
		var au = load(f)
		sound.stream = au
		sound.play()
		pass
	else:# de lo contrario lo detiene
		sound.stop()
	
	pass
func seti(f:String) -> void:
	
	if fname!=f:# si el archivo a reproducir es el mismo no hacer nada
		audio.stop()
		var au = load(f)
		audio.stream = au
		audio.play()
		audio.playing = true
		fname = f
		pass
	elif f=="none": # si es "none" parar la musica
		audio.stop()
	
	
	pass
