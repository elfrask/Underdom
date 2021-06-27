extends Node

var recort = "res://lang/"
var set_lang = ""
var MENUGAME = "res://lang/gui/menugame.json"

func set_data(d:String):
	if Directory.new().dir_exists(d):
		print("se ha establecido el nuevo paquete de idiomas")
		set_lang = Lib.trim(d)
	else:
		print("no se ha encontrado el paquete de idiomas")
		set_lang = recort
		pass

func get(f:String):
	f=Lib.trim(f)
	var salida = {}
	var ref = ""
	if f.substr(0, len(recort)):
		ref = f.substr(len(recort))
		f=set_lang+f.substr(len(recort))
		pass
	else:
		
		pass
	var fs = File.new()
	if fs.file_exists(f):
		fs.open(f, File.READ)
		salida = JSON.parse(fs.get_as_text()).result
		pass
	elif fs.file_exists(recort+ref):
		fs.open(recort+ref, File.READ)
		salida = JSON.parse(fs.get_as_text()).result
		pass
	return salida
