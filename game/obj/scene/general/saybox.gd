extends StaticBody2D


export (String) var dialog_static = "none"
export (String) var nombre = ""
export (bool) var Disable = false
var dialogo = []
var event
func _ready():
	$coll.disabled = Disable
	event = get_node_or_null("event")
	
	var di = game.lang["cartel"]
	var to = dialog_static.split("/")
	for i in to:
		di = di[i]
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


