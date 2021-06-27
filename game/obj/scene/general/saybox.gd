extends StaticBody2D

export (String, FILE, "*.json, *.JSON") var dialog_file = "none"
export (String) var nombre = ""
export (bool) var Disable = false
var dialogo = []
var event
func _ready():
	$coll.disabled = Disable
	event = get_node_or_null("event")
	
	if dialog_file == "none": dialog_file = Lang.recort + "none.json"
	
	var di = Lang.get(dialog_file)
	
	if (nombre == "") and (!(di is Array)):
		nombre = di.get("name", "")
		dialogo = di["say"]
	else:
		dialogo = di
	
	pass 

func say():
	
	
	var decir = Lib.dialogbox(event)
	decir["name"] = nombre
	decir["text"] = dialogo
	return decir


