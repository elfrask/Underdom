extends KinematicBody2D

export (Texture) var texture:Texture
export (String) var dialog_static = "none"
export (String) var nombre = ""
var dialogo = []
var event
func _ready():
	event = get_node_or_null("event")
	
	var di = game.lang["dialogos"]
	var to = dialog_static.split("/")
	for i in to:
		di = di[i]
	if nombre == "":
		nombre = di.get("name", "")
		dialogo = di["say"]
	else:
		dialogo = di
	$vs.texture = texture
	
	pass 

func say():
	
	var out = []
	if str(event)!="[Object:null]": out.append(event)
	
	return [nombre, dialogo, out, false]

