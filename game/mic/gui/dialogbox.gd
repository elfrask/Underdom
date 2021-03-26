extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lon = 0
var texto = ""
var limit = 45
var N = "\n"
var dii = []
var sel = 0
var nombre = ""
var final = []
var cara = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Api.set("say", self)
	
	pass # Replace with function body.



func printf(text = ""):
# warning-ignore:unused_variable
	var i = 0
# warning-ignore:unused_variable
	var salida = ""
	$u/text.text = ""
	
	lon = 0
	texto = text
	
	pass

func play(nom, dialogos = [], on_finish=[], face=false):
	dii = dialogos
	texto = ""
	lon = 0
	sel = -1
	$u/text.text = ""
	visible = true
	nombre = nom
	final = on_finish
	cara = face 
	pass
func isplay():
	
	return visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	
	if visible:
		if (sel == -1):
			if nombre == "": $u/backin.visible = false; else: $u/backin.visible = true
			sel +=1
			printf(dii[sel])
			$u/backin/name.text = nombre
			pass
		
		if Input.is_action_just_pressed("aceptar"):
			if len($u/text.text) >= len(texto):
				if sel == len(dii)-1:
					for functiones in (final):
						functiones._dialog_finish()
						#Lib.funci(functiones).call()
						
						pass
					visible = false
					pass
				else:
					sel +=1
					printf(dii[sel])
					pass
				pass
			pass
		if Input.is_action_just_pressed("cancelar"):
			$u/text.text = texto
			pass
		
		pass
	pass


func _on_Timer_timeout():
	if visible:
		if len($u/text.text) < len(texto):
			$u/text.text = $u/text.text + texto[len($u/text.text)]
		pass
	pass # Replace with function body.
