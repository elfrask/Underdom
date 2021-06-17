extends KinematicBody2D

export (Texture) var texture:Texture
export (String) var dialog_static = "none"
export (String) var nombre = ""
export (String) var voice = "letters"
export (bool) var Disable = false
var dialogo = []
var event
func _ready():
	$coll.disabled = Disable
	$vs.visible = !Disable
	event = get_node_or_null("event")
	
	var di = game.lang["dialogos"]
	var to = dialog_static.split("/")
	for i in to:
		di = di[i]
	if (nombre == "") and (!(di is Array)):
		nombre = di.get("name", "")
		dialogo = di["say"]
	else:
		dialogo = di
	$vs.texture = texture
	
	pass 

func say():
	var out = Lib.dialogbox(event)
	out["name"] = nombre
	out["text"] = dialogo
	out["face"] = texture
	return out

