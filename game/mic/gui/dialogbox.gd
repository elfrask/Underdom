extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lon = 0
var texto = ""
var limit = 45
var N = "\n"
var dii = []
var sel = 0
var nombre = ""
var eventos = []
var cara = false
var voice = "global"
var sound = ""
var persistencia = true
const vel = 0.025

var modo = "text"


var opciones = ["..."]
var sec = 0
var action:Array

var puntos = [
	"u/opt/p1",
	"u/opt/p2",
	"u/opt/p3",
	"u/opt/p4",
	"u/opt/p5",
	"u/opt/p6",
]
var opt = [
	"u/opt/list/T1",
	"u/opt/list/T2",
	"u/opt/list/T3",
	"u/opt/list/T4",
	"u/opt/list/T5",
	"u/opt/list/T6",
]
var limite = 1



var bee:bool = false
# Called when the node enters the scene tree for the first time.

func issay():
	return bee

func _ready():
	
	Api.set("say", self)
	visible = false
	$u/opt.visible = false
	pass # Replace with function body.

func options(data):
	sec = 0
	texto = data["text"]
	opciones = data["data"]
	action = data["events"]
	#print(action)
	var indice = 0
	for i in opt:#vaciar opciones
		get_node(i).text = ""
		pass
		
	for i in opciones:
		if indice >= 6: 
			break
		get_node(opt[indice]).text = i
		indice+=1
		pass
	limite = indice+1
	$u/text.text = ""
	modo = "opt"
	pass

func lanzar(text = ""):
	modo = "text"
	var i = 0
	var salida = ""
	$u/text.text = ""
	
	lon = 0
	texto = text
	
	pass

func next():
	if len($u/text.text) >= len(texto):
		if sel == len(dii)-1:
			Lib.playevent(eventos, "finish")
			visible = false
			pass
		else:
			sel +=1
			var dato = dii[sel]
			if dato is String:
				lanzar(dato)
			elif dato is Dictionary:
				if dato["type"]=="options":
					options(dato)
					pass
			pass
		pass
	else:
		bee = false
	pass
	
	pass


func play(data={}, on_finish=[]):
	dii = data["text"]
	persistencia = data["persist"]
	#print("persistencia: ", persistencia)
	texto = ""
	lon = 0
	$Timer.wait_time = data["speed"]*vel
	sel = -1
	$u/text.text = ""
	visible = true
	nombre = data["name"]
	eventos = data["events"]
	cara = data["face"]
	modo = "text"
	var defecto = "res://assets/voice/letter.wav"
	if File.new().file_exists("res://assets/voice/"+data["voice"]+".wav"):
		sound = "res://assets/voice/"+data["voice"]+".wav"
		pass
	elif File.new().file_exists("res://assets/voice/"+data["voice"]+".ogg"):
		sound = "res://assets/voice/"+data["voice"]+".ogg"
		pass
	elif File.new().file_exists("res://assets/voice/"+data["voice"]+".mp3"):
		sound = "res://assets/voice/"+data["voice"]+".mp3"
		pass
	else:
		sound = "res://assets/sound/letter.wav"
		pass
	
	pass
func isplay():#si esta ejecutandose
	
	return visible

func _process(delta):
	
	if visible:
		if (sel == -1):
			$u/backin.visible = !(nombre == "")
			sel +=1
			#print(dii)
			lanzar(dii[sel])
			$u/backin/name.text = nombre
			Lib.playevent(eventos, "play")
			pass
		if (modo == "text"):
			if Input.is_action_just_pressed("aceptar"):
				next()
			if Input.is_action_just_pressed("cancelar"):
				Auda.beat(sound, persistencia)
				$u/text.text = texto
				pass
			pass
		elif (modo=="opt"):
			
			if $u/opt.visible:
				var mover = (
					-int(Input.is_action_just_pressed("up"))
					+int(Input.is_action_just_pressed("down"))
				)
				
				if mover!=0:
					Auda.beat(Lib.control_sound)
					sec+=mover
					if sec==limite-1:
						sec=0
						pass
					if sec==-1:
						sec=limite-1
				
				$u/opt/sel.position = get_node(puntos[sec]).position
				
				if Input.is_action_just_pressed("aceptar"):
					#print(action)
					Auda.beat(Lib.control_sound_acept)
					for i in action:
						i.play(sec)
						pass
					$u/opt.visible = false
					next()
				pass
				
			pass
		pass
	pass


func _on_Timer_timeout():
	if visible:
		if len($u/text.text) < len(texto):
			$u/text.text = $u/text.text + texto[len($u/text.text)]
			Auda.beat(sound, persistencia)
			
		pass
	if (modo=="opt"):
		if len($u/text.text) == len(texto):
			if !$u/opt.visible:
				$u/opt.visible=true
	pass # Replace with function body.
