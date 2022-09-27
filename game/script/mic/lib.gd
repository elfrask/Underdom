extends Node

var control_sound_cancel = "res://assets/sound/cancel.wav"
var control_sound = "res://assets/sound/control.wav"
var control_sound_acept = "res://assets/sound/done.wav"

enum vista {
	Arriba=0,
	Derecha=1,
	Abajo=2,
	Izquierda=3
}
func interpolate(n):
	var salida = 0
	if n<0:salida=-1
	elif n>0:salida=1
	return salida
#usar este valot unicamente cuando estes seguro que estas pasando una funcion
class Funcion:
	var call
	func _init(s):
		call = s
		pass
	
	pass
func trim(v:String):
	while v.substr(0,1) ==" ":
		v=v.substr(1)
	while v.substr(len(v)-1, 1) == " ":
		v=v.substr(0, len(v)-1)
	return v
	

func isnull(o):
	
	return str(o)!="[Object:null]"
func funci(f): 
	
	return Funcion.new(f)
func dialogbox(event="[Object:null]") -> Dictionary:

	var out = []
	#print(event)
	if str(event)!="[Object:null]": out.append(event)
	return {
		"events":out,
		"text":["texto"],
		"face":false,
		"name":"",
		"voice":"global",
		"persist":false,
		"speed":1.0,
		"list":[]
	}
func dialog_options(options = ["1", "2", "3", "4"], event="[Object:null]"):
	var out = []
	#print(event)
	if str(event)!="[Object:null]": out.append(event)
	return {
		"events":out,
		"data":options,
		"type":"options",
		"text":"..."
	}
#res://lang/options/
func dialog_process(data, e=[]):
	var salida = []
	var ee = 0
	for i in data:
		if i is String: salida.append(i)
		elif i is Dictionary:
			if i["type"]=="options":
				var nodo = get_node_or_null("vacio")
				var res = len(e) > ee
				#print("resultado: val: "+str(ee) + " data: ", e)
				if res: 
					nodo =(e[ee])
				#print(nodo)
				var t = dialog_options(i["data"], nodo)
				t["text"] = i["text"]
				salida.append(t)
				ee+=1
				pass
			pass
		pass
	
	return salida

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

func playevent(event:Array, nom:String="", data:Dictionary={}):
	
	for valor in (event):
		var obtener:Dictionary =valor.data
		var yes = obtener.get(nom, false)
		if !(yes is bool):
			if str(data)=="{}":
				return yes.play()
			else:
				return yes.play(data)
