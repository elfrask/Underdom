extends Control

export (Array, String) var lista = []
export (bool) var center = false
export (NodePath) var eventScript
export (bool) var enable = true
export (int) var sizefont = 16

var sel = 0
var Tfont = preload("res://Obj/gui/Tfont.tscn")
var event = []

func _ready():
	var a:VBoxContainer = $ops
	var obj = get_node(eventScript)
	if obj:
		event.append(obj)
	
	for i in lista:
		var t:Label =Tfont.instance()
		t.text = i
		if center:
			t.align = t.ALIGN_CENTER
		a.add_child(t)
	
	_ling()
	pass

func _ling():
	var a:VBoxContainer = $ops
	var met = a.get_children()
	
	if len(lista) == 0: 
		print("none values")
		return 
	
	for i in met:
		i.modulate = Color(1, 1, 1, 1)
		pass
	met[sel].modulate = Color(1, 1, 0, 1)
	

func _move(delta):
	if Input.is_action_just_pressed("arriba"):
		sel-=1
		if sel == -1: sel = len(lista)-1
		_ling()
		pass
	if Input.is_action_just_pressed("abajo"):
		sel+=1
		if sel == len(lista): sel = 0
		_ling()
		pass
	if Input.is_action_just_pressed("z"):
		for i in event:
			i.play(sel)
			pass
		pass
	
	pass

func _process(delta):
	if visible and enable:
		_move(delta)
		pass
	pass

func render():
	pass
