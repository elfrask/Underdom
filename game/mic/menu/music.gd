extends Control

var sel = 0
var nl = 0
var base = {
	"name":"ninguno",
	"path":"none",
	"autor":"ninguno"
}
var audio = ""
var mus = base 
var lista = []
var lista_renderizada = []

func _ready():
	$bg/U/data/title.text = game.lang["gui"]["music"]["title"]
	$bg/U/data/gui.text = game.lang["gui"]["music"]["author"]
	loaddata()
	render(0)
	pass
func audi(path):
	
	if path!=audio:
		$a.stop()
		$a.stream=load(path)
		$a.play()
		audio =path
		pass
	elif path=="none":
		$a.stop()
	pass
func render(i):
	
	for x in range(0, 10):
		if lista[i+x]["path"] != "none":
			get_node("bg/L/list/" + str(x)).text = "OST: "+str(i+x)+"."
		else:
			get_node("bg/L/list/" + str(x)).text = "-----------"
		
		pass
	
	pass
func loaddata():
	var path = "res://basedata/music.json"
	var list_file = File.new()
	list_file.open(path, File.READ)
	var lista_cruda = JSON.parse(list_file.get_as_text()).result
	lista = lista_cruda["list"]
	var faltante = ((int(len(lista))%10)-10)*-1
	var grid = int(int(len(lista)-faltante)/10)
	for i in range(0, faltante):
		lista.append(base)
		pass
	
	 
	pass
func _process(delta):
	var sec = $bg/L/sel
	if Input.is_action_just_pressed("up"):
		sel -= 1
		if sel == -1:
			sel = 9
			nl -=10
			if nl <= -1:
				nl=int(len(lista))-10
			render(nl)
			
		pass
	elif Input.is_action_just_pressed("down"):
		sel += 1
		if sel == 10:
			sel = 0
			nl +=10
			if nl >= len(lista):
				nl=0
			render(nl)
			
		pass
	$bg/L/nu.text = str((int(nl/10))+1) +"/"+str(int(len(lista)/10))
	sec.position = get_node("bg/L/sec/" + str(sel)).position;
	if Input.is_action_just_pressed("cancelar"):
		if $a.playing:
			$a.stop()
			audio = ""
			pass
		else:
			get_tree().change_scene("res://mic/menu/main.tscn")
		pass
	if Input.is_action_just_pressed("aceptar"):
		$bg/U/data/autor.text = lista[sel+nl]["autor"]
		$bg/U/data/name.text = lista[sel+nl]["name"]
		audi(lista[sel+nl]["path"])
		pass
	
	pass
