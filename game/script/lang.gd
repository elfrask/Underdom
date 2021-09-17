extends Node

var locatedef = "res://lang/"
var rute = "res://lang/"

func _ready():
	pass

func setlang(path:String=locatedef):
	rute = path
	pass

func trim(p:String=rute):
	return p.substr(len(locatedef))

func load_file(f:String="none.json"):
	var fi = File.new()
	var path = ""
	if fi.file_exists(rute + "/" + f):
		path = rute + "/" + f
		pass
	elif fi.file_exists(locatedef + "/" + f):
		path = locatedef + "/" + f
		pass
	else:
		return {}
	
	fi.open(path, File.READ)
	var ret = JSON.parse(fi.get_as_text()).result
	return ret

