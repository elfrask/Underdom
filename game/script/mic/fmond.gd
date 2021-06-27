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

func beat(f) -> void:
	if f is String:
		if f != "none":# si no es none entonces reproducir el sonido
			sound.stop()
			var au = load(f)
			
			#verifica el tipo de archivo y modificalo para que no se haga bucle
			if au is AudioStreamOGGVorbis: au.loop = false
			if au is AudioStreamSample: au.loop_mode = AudioStreamSample.LOOP_DISABLED
			if au is AudioStreamMP3: au.loop = false
			
			sound.stream = au
			sound.play()
			pass
		else:# de lo contrario lo detiene
			sound.stop()
		pass
	elif (
		(f  is AudioStreamOGGVorbis) or
		(f  is AudioStreamSample) or
		(f  is AudioStreamMP3)
		) :
		var au = f
		if au is AudioStreamOGGVorbis: au.loop = false
		if au is AudioStreamSample: au.loop_mode = AudioStreamSample.LOOP_DISABLED
		if au is AudioStreamMP3: au.loop = false
		
		sound.stream = au
		sound.play()
		pass
	
	pass
func seti(f) -> void:
	
	if f is String:
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
	elif (
		(f  is AudioStreamOGGVorbis) or
		(f  is AudioStreamSample) or
		(f  is AudioStreamMP3)
		) :
		var au = f
		if au is AudioStreamOGGVorbis: au.loop = false
		if au is AudioStreamSample: au.loop_mode = AudioStreamSample.LOOP_DISABLED
		if au is AudioStreamMP3: au.loop = false
		
		sound.stream = au
		sound.play()
		pass
	
	pass
