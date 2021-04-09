extends Control

var path = "res://basedata/galery.json"
var sel:int=0
var limit:int = 0

func _ready():
	$bg/L/title.text = game.lang["gui"]["galery"]["title"]
	$bg/L/gui1.text = game.lang["gui"]["galery"]["gui1"]
	$bg/L/des.text = game.lang["gui"]["galery"]["des"]
	img(0)
	pass

func img(index:int):
	
	var file  = File.new()
	
	file.open(path, File.READ)
	var data = JSON.parse(file.get_as_text()).result
	data = data["list"]
	limit = len(data)
	var imagen=data[index]
	
	if imagen["path"] == "none":
		$bg/R/marco/c/img.texture = Texture.new()
		$bg/L/autor.text = "----------"
		$bg/L/detalle.text = "..."
		pass
	else:
		$bg/R/marco/c/img.texture = load(imagen["path"])
		$bg/L/autor.text = imagen["autor"]
		$bg/L/detalle.text = imagen["des"]
		pass
	
	pass

func _process(delta):
	$count.text = str(sel+1) + "/" + str(limit)
	if Input.is_action_just_pressed("cancelar"):
		get_tree().change_scene("res://mic/menu/main.tscn")
	if Input.is_action_just_pressed("right"):
		Auda.beat("res://assets/sound/control.wav")
		sel+=1
		if limit == sel:
			sel=0
		img(sel)
	if Input.is_action_just_pressed("left"):
		Auda.beat("res://assets/sound/control.wav")
		sel-=1
		if -1 == sel:
			sel=limit-1
		img(sel)
	
	
	pass
