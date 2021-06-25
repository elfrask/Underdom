extends Node

var control_sound_cancel = "res://assets/sound/cancel.wav"
var control_sound = "res://assets/sound/control.wav"
var control_sound_acept = "res://assets/sound/done.wav"
#usar este valot unicamente cuando estes seguro que estas pasando una funcion
class Funcion:
	var call
	func _init(s):
		call = s
		pass
	
	pass
func isnull(o):
	
	return str(o)!="[Object:null]"
func funci(f): 
	
	return Funcion.new(f)
func dialogbox(event="[Object:null]"):

	var out = []
	print(event)
	if str(event)!="[Object:null]": out.append(event)
	return {
		"onfinish":out,
		"text":["texto"],
		"face":false,
		"name":"",
		"voice":"global"
	}
func re_list():
	var salida = []#generar un recopilador
	var index = 0#crear una indexacion empezando de 0
	for i in game.player["char"]:#con el for recopilar los personajes
		if game.player["char"][i]["show"]:#si el personaje actual se muestra
			salida.append({
				"name":i, 
				"index":index, 
				"char":game.player["char"][i]
				})#añadirlo a la lista
			#get_node("lista/t" + str(index)).visible = true#y renderizarlo
			pass
		else:#si no
			#get_node("lista/t" + str(index)).visible = false# ocultarlo
			
			pass
		index +=1#sumarle 1 al indexador
		pass
