extends StaticBody2D


export (String) var nombre = ""
export (Array) var di = []
var event
func _ready():
	event =get_node_or_null("event")
	pass
func say():
	
	var out = []
	if str(event)!="[Object:null]": out.append(event)
	
	return [nombre, di, out, false]

func _process(delta):
	pass
