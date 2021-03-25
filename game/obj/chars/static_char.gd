extends KinematicBody2D

export (Texture) var texture
export (String) var dialog_static = "none"
var dialogo = []

func _ready():
	var di = game.lang["dialogos"]
	var to = dialog_static.split("/")
	for i in to:
		di = di[i]
		pass
	dialogo = di
	pass 



