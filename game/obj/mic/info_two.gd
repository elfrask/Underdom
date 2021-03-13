extends Control

var data = {}
var nombre:String = ""
func _ready():
	visible = false
	get_parent().visible=false
	pass
func _process(delta):
	if visible:
		if Input.is_action_just_pressed("cancelar"):
			visible = false
			get_parent().visible = false
		pass
	pass


func _on_info_visibility_changed():
	if visible:
		var basic = $basic
		var more = $more
		$foto/t.texture = game.foto[nombre]
		basic.text =(str(data['name'])+"\nlv " + str(data['lv'])+ 
		"/100\nDef: "+str(int(data['def'])+int(data['armor'].get("def", 0))) +
		"\nAtk: " + str(int(data['atk'])+ int(data['hit'].get("atk", 0))) +
		"\nHp: " + str(game.hp["frisk"])+"\nPE: " + str(data['pe']))
		
		more.text =(game.lang["gui"]["info"]["lv"] + str(data["lvup"]) + "\n\n"
		+ game.lang["gui"]["info"]["force"] + str(data["atk"]) + "\n" +
		game.lang["gui"]["info"]["weapon"] + str(data["hit"].get("atk", 0)) 
		+"\n\n" + game.lang["gui"]["info"]["resist"] + str(data["def"]) + "\n"+
		game.lang["gui"]["info"]["shield"] + str(data["armor"].get("def", 0))+
		"\n\n"+ game.lang["gui"]["info"]["max"] + str(data["max"]) + 
		"\n\n" + str(game.lang["soul"][data["soul"]])
		)
		pass 
		
		
	
	pass
	
	
	
