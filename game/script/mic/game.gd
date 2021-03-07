extends Node

var frisk = "frisk" 
var chara = "chara" 
var asriel = "asriel"

var datagame = {
	"name":"UnderDom",
	"completname":"Under Kingdom's",
	"ver":"0.1a",
	"gd_ver":"godot 3.2.3 stable"
}
var lang = {}
var player = {
	"coin":0,
	"tlf":0,
	"fun":0,
	"x":0,
	"y":0,
	"lang":"es",
	"room":"main",
	"name":false,
	"pro":0.0,
	"char":{
		"frisk":{
			"lv":1,
			"atk":1,
			"def":2,
			"lvup":10,
			"pe":0,
			"max":20,
			"armor":{},
			"hit":{},
		},
		"chara":{
			"lv":1,
			"atk":2,
			"def":1,
			"lvup":20,
			"pe":0,
			"max":25,
			"armor":{},
			"hit":{},
		},
		"asriel":{
			"lv":1,
			"atk":1,
			"def":5,
			"lvup":20,
			"pe":0,
			"max":15,
			"armor":{},
			"hit":{},
		},
	},
	"time":int(0),
	"inv":[
		false,
		false,
		false,
		gen_obj("cuchillo", "atk", had(0, 10, 0), [frisk, chara, asriel]),
		gen_obj("cuchillo", "atk", had(0, 10, 0), [frisk, chara, asriel]),
		gen_obj("cuchillo", "atk", had(0, 10, 0), [frisk, chara, asriel]),
		gen_obj("cuchillo Frisk", "atk", had(0, 5, 0), [frisk]),
		gen_obj("cuchillo Chara", "atk", had(0, 100, 0), [chara]),
		
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
	],
	"story":{
		
	}
}
#		gen_obj("Escudo de piedra", "def", data(0,0,100), ["frisk", "chara", "asriel"]),

func had(hp=0, atk=0, def=0):
	
	return {
		"hp":hp,
		"atk":atk,
		"def":def
	}

func gen_obj(nombre="HotDog", tipo= "hp", data = {"hp":10}, character=["frisk", "chara", "asriel"]):
	data["nick"] = nombre
	data["tipo"] = tipo
	data["char"] = character
	return data

func add_obj(nombre="HotDog", tipo= "hp", data = {"hp":10}, character=["frisk", "chara", "asriel"]):
	
	data["char"] = character
	data["nick"] = nombre
	data["tipo"] = tipo
	var i = 0
	for x in player["inv"]:
		
		if str(x) == "False":
			player["inv"][i] = data
			break
		
		i+=1
		pass
	
	pass

func include(arr, val):
	
	for x in arr:
		
		if x == val:
			
			return true
		
		pass
	
	return false

func use(personaje, id):
	var dat = player["inv"][id]
	if str(dat) =="False":
		player["inv"][id] = false
		#print("vacio")
		
		return [false, "vacio"]
	#print(dat["char"])
	if include(dat["char"], personaje):
		if dat["tipo"] == "hp":
			hp[personaje] += dat["hp"]
			if hp[personaje] > player["char"][personaje]["max"]:
				hp[personaje] = player["char"][personaje]["max"]
				pass
			player["inv"][id] = false
			pass
		if dat["tipo"] == "atk":
			#print("has cambiado tu arma")
			var tmp_ob = player["char"][personaje]["hit"]
			player["char"][personaje]["hit"] = dat
			if str(tmp_ob) == "{}":tmp_ob = false
			player["inv"][id] = tmp_ob
			pass
		if dat["tipo"] == "def":
			#print("has cambiado la defensa")
			var tmp_ob = player["char"][personaje]["armor"]
			player["char"][personaje]["armor"] = dat
			if str(tmp_ob) == "{}":tmp_ob = false
			player["inv"][id] = tmp_ob
			pass
		pass
	else:
		print("'"+personaje+"' no puede usar un '"+ dat["nick"] + "'")
		Api.get("say").play("", [
			"'"+personaje+"' "+ lang["gui"]["item"]["nouse"] +" '"+ dat["nick"] + "'"
		])
		return [false, "'"+personaje+"' no puede usar un '"+ dat["nick"] + "'"]
	
	pass


var hp
func regen():
	hp={
		"frisk":player["char"]["frisk"]["max"],
		"chara":player["char"]["chara"]["max"],
		"asriel":player["char"]["asriel"]["max"],
	}
	pass

func load_lang(pkg):
	var fs = File.new()
	fs.open("res://lang/" + pkg +".json", File.READ)
	lang =  JSON.parse(fs.get_as_text()).result
	pass

func loadgame():
	var fs= File.new()
	if true:#(!fs.file_exists("user://game.save")):
		fs.open("user://game.save", File.WRITE)
		randomize()
		player["fun"] = randi()%100
		fs.store_string(JSON.print(player))
		pass
	else:
		fs.open("user://game.save", File.READ)
		player = JSON.parse(fs.get_as_text()).result
		
		pass
	load_lang(player["lang"])
	pass


func savegame():
	
	var fs = File.new()
	fs.open("user://game.save", File.WRITE)
	fs.store_string(JSON.print(player))
	
	pass



func _ready():
	loadgame()
	regen()
	
	pass


func _process(delta):
	pass
