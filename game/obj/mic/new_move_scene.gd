extends Node2D

#export (String) var nombre = "main"
export (NodePath) var player
#export (Array, NodePath) var points=[]
var points:Array = []
export (String) var sound = ""
var curret_scene:String = ""
var punto:String=""

func _ready():
	Api.set("room", self)
	curret_scene = (get_tree().current_scene.filename)
	punto = game.player["last"]["point"]
	#$Timer.start()

func loadpoints():
	points = game.get_points()
	
	var pla:KinematicBody2D = get_node(player)
	if sound=="":
		#Auda.seti("res://assets/music/menu0.ogg")
		pass
	else:
		Auda.seti("res://assets/music/" + sound + ".ogg")
	#print(points)
	for i in points:
		var x:Position2D = i
		if x.nombre == punto:
			
			pla.position = x.position
			pla.vew(x.see)
			break
		pass
	
	
	pass


func save_pos(p):
	game.player["last"]["room"] = curret_scene
	game.player["last"]["point"] = p
	
	pass
	
func to_scene(s, p):
	
	var pla = get_node(player)
	game.player["last"]["room"] = s
	game.player["last"]["point"] = p
	print("'"+s+"'")
	game.clear_points()
	
	get_tree().change_scene(s)
	pass



func _on_Timer_timeout():
	loadpoints()
	pass # Replace with function body.
