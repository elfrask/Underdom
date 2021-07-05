extends KinematicBody2D

export (Texture) var texture:Texture
export (Texture) var texture_face:Texture
export (String, FILE, "*.json, *.JSON") var dialog_file = "none"
export (String) var nombre = ""
export (bool) var persist = false
export (float) var speed = 1.0
export (String) var voice = "letters"
export (bool) var Disable = false
var dialogo = []
var event
var list

func _ready():
	$coll.disabled = Disable
	$vs.visible = !Disable
	event = get_node_or_null("events")
	list = get_node_or_null("list")
	
	if dialog_file == "none": dialog_file = Lang.recort + "none.json"
	
	var di = Lang.get(dialog_file)
	if (nombre == "") and (!(di is Array)):
		nombre = di.get("name", "")
		dialogo = di["say"]
	else:
		dialogo = di
	$vs.texture = texture
	
	pass 

func say():
	if (list is Node): list = list.data
	else: list = []
	
	var out = Lib.dialogbox(event)
	out["name"] = nombre
	out["text"] = Lib.dialog_process(dialogo, list)
	out["face"] = texture_face
	out["voice"] = voice
	out["persist"] = persist
	out["speed"] = speed
	
	return out

