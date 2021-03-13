extends Node
#establecer nombres comunes
var frisk = "frisk" 
var chara = "chara" 
var asriel = "asriel"

#datos del juego sobre su construccion y version
var datagame = {
	"name":"UnderDom",
	"completname":"Under Kingdom's",
	"ver":"0.1a",
	"gd_ver":"godot 3.2.3 stable"
}
var lang = {}#el idioma
#la partida

#con esta funcion generamos el personaje 
#(nombre, ataque, defensa, subir de nivel, maximo hp, mostrar, alma)


func gen_char(name:String = "frisk", atk:int = 1, def:int = 1, lvup:int = 10, maxi:int = 20, show:bool = true, soul:String = "soul"):
	return({
		"name":name,
		"lv":1,
		"atk":atk,
		"def":def,
		"lvup":lvup,
		"pe":0,
		"max":maxi,
		"armor":{},
		"hit":{},
		"show":show,
		"soul":soul
	})
	pass
var player

var foto = {
	"frisk":preload("res://assets/sprites/characters/frisk/frame0.png"),
	"chara":preload("res://assets/sprites/characters/chara/frame0.png"),
	"asriel":preload("res://assets/sprites/characters/asriel/frame0.png"),
}



func ini():
	player = {
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
			"frisk": gen_char("Frisk", 2, 3, 10, 20, true, "red"),
			"chara": gen_char("Chara", 4, 3, 20, 25, true, "red"),
			"asriel": gen_char("Asriel", 2, 5, 20, 15, true, "white"),
			"liz": gen_char("Liz", 2, 4, 10, 15, false, "rose"),
			"samuel": gen_char("Samuel", 3, 2, 10, 30, false, "plata"),
			"kris": gen_char("Kris", 2, 2, 20, 25, false, "red"),
			"susie": gen_char("Susie", 5, 3, 25, 35, false, "white"),
			"ralsei": gen_char("Ralsei", 2, 2, 15, 15, false, "white"),
			
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
	pass
#		gen_obj("Escudo de piedra", "def", data(0,0,100), ["frisk", "chara", "asriel"]),

func had(hp=0, atk=0, def=0):# hp atk def siglas had. genera los valores basicos de los objetos
	
	return ({
		"hp":hp,
		"atk":atk,
		"def":def
	})# devolver los objetos con estos valores
	
#generar el objeto pasando las propiedades
func gen_obj(nombre="HotDog", tipo= "hp", data = {"hp":10}, character=["frisk", "chara", "asriel"]):
	data["nick"] = nombre#meter nombre
	data["tipo"] = tipo#meter tipo
	data["char"] = character#meter personajes
	return data
#añadir un objeto de forma arbitraria
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

func include(arr, val): #verifica si un valor hay en el arreglo
	
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
	if include(dat["char"], personaje):# si el personaje segun el objeto esta incluido segun el personaje que selecciono el jugador
		if dat["tipo"] == "hp":# si el objeto es del tipo aumento de hp
			hp[personaje] += dat["hp"]# sumarlo con la vida
			if hp[personaje] > player["char"][personaje]["max"]:# si la suma resulta ser mayor que el maximo
				hp[personaje] = player["char"][personaje]["max"]# reasignar al maximo
				pass
			player["inv"][id] = false
			pass
		if dat["tipo"] == "atk":# si el objeto es del tipo aumento de atk
			
			var tmp_ob = player["char"][personaje]["hit"]# guardar referencia del objeto de ataque actual
			player["char"][personaje]["hit"] = dat# asignar el nuevo objeto al personaje para aumentar su ataque
			if str(tmp_ob) == "{}":tmp_ob = false# si no tenia un objeto entonces lo convertira en falso
			player["inv"][id] = tmp_ob#guardar el objeto que tenia puesto en el inventario
			pass
		if dat["tipo"] == "def":# si el objeto es del tipo aumento de def
			
			var tmp_ob = player["char"][personaje]["armor"]# guardar referencia del objeto de defensa actual
			player["char"][personaje]["armor"] = dat# asignar el nuevo objeto al personaje para aumentar su ataque
			if str(tmp_ob) == "{}":tmp_ob = false# si no tenia un objeto entonces lo convertira en falso
			player["inv"][id] = tmp_ob#guardar el objeto que tenia puesto en el inventario
			pass
		pass
	else:
		#si el personaje seleccionado no esta en la lista decir que el personaje no pudo usar el objeto
		print("'"+personaje+"' no puede usar un '"+ dat["nick"] + "'")
		Api.get("say").play("", [
			"'"+personaje+"' "+ lang["gui"]["item"]["nouse"] +" '"+ dat["nick"] + "'"
		])
		return [false, "'"+personaje+"' no puede usar un '"+ dat["nick"] + "'"]
	
	pass


var hp
func regen():# regenerar a los personajes
	hp={
		"frisk":player["char"]["frisk"]["max"],
		"chara":player["char"]["chara"]["max"],
		"asriel":player["char"]["asriel"]["max"],
	}
	pass

func load_lang(pkg): #cargar el idioma
	var fs = File.new()
	fs.open("res://lang/" + pkg +".json", File.READ)
	lang =  JSON.parse(fs.get_as_text()).result
	pass

func loadgame():#cargar el juego si no lo logra usa una plantilla
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


func savegame():#guardar el juego
	
	var fs = File.new()
	fs.open("user://game.save", File.WRITE)
	fs.store_string(JSON.print(player))
	
	pass



func _ready(): # al iniciar
	ini()
	loadgame()
	regen()
	
	pass


func _process(delta): # se ejecuta todo el tiempo
	pass
