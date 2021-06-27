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
			Auda.beat("res://assets/sound/cancel.wav")
			visible = false
			get_parent().visible = false
		pass
	pass


func _on_info_visibility_changed():
	if visible:
		var basic = $basic
		var more = $more
		var idioma = Lang.get(Lang.MENUGAME)["gui"]["info"]
		var alma = Lang.get(Lang.MENUGAME)["soul"]
		
		$foto/t.texture = game.foto[nombre]
		basic.text =(str(data['name'])+"\nlv " + str(data['lv'])+ 
		"/100\nDef: "+str(int(data['def'])+int(data['armor'].get("def", 0))) +
		"\nAtk: " + str(int(data['atk'])+ int(data['hit'].get("atk", 0))) +
		"\nHp: " + str(game.hp["frisk"])+"\nPE: " + str(data['pe']))
		
		more.text =(idioma["lv"] + str(data["lvup"]) + "\n\n"
		+ idioma["force"] + str(data["atk"]) + "\n" +
		idioma["weapon"] + str(data["hit"].get("atk", 0)) 
		+"\n\n" + idioma["resist"] + str(data["def"]) + "\n"+
		idioma["shield"] + str(data["armor"].get("def", 0))+
		"\n\n"+ idioma["max"] + str(data["max"]) + 
		"\n\n" + str(alma[data["soul"]])
		)
		pass 
		
		
	
	pass
	
	
	
