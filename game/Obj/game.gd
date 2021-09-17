extends Node

func _ready():
	dialog([
		"Test de dialogo 1",
		"Test de dialogo 2",
		"Test de dialogo 3",
	])
	pass

var dial = []
var cu_dial = ""
var dial_ind = 0
var dial_while = false
var next_dial = false


func dialog(text=[]):
	dial = text
	cu_dial = ""
	dial_ind = 0
	dial_while = true
	$delay.start()
	pass

func set_let():
	var tfont = $Node2D/init/gui/dialog/di
	var tt = $Node2D/init/gui/dialog
	if cu_dial == "":
		if len(dial) != dial_ind:
			cu_dial = dial[dial_ind]
			dial_ind+=1
			tfont.text = ""
		else:
			dial_while = false
			tt.visible = false
			$delay.stop()
			tfont.text = ""
			return
		pass
	
	if cu_dial != tfont.text:
		tfont.text+=cu_dial[len(tfont.text)]
		pass
	else:
		next_dial=true
		print("terminado")
		$delay.stop()
	pass

func _process(delta):
	var tt = $Node2D/init/gui/dialog
	var cc = $Node2D/init/gui/control
	
	if tt.visible:
		
		if next_dial:
			if Input.is_action_just_pressed("z"):
				next_dial = false
				cu_dial = ""
				$delay.start()
			
			pass
		pass
	
	cc.visible = false in [tt.visible]
	
	
	pass




func _on_delay_timeout():
	set_let()
	pass 
