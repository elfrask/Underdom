extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sel = 0
var pos = [
	"Control/sec1",
	"Control/sec2",
	"Control/sec3",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var modo="normal"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$main.visible = modo=="normal"
	$extras.visible = modo=="extra"
	if Input.is_action_just_pressed("up"): #al dar la tecla asignada (arriba)
		sel -=1 #subir el cursor
		Auda.beat("res://assets/sound/control.wav")
		pass
	if Input.is_action_just_pressed("down"): # al dar a la tecla asignada (abajo)
		Auda.beat("res://assets/sound/control.wav")
		sel +=1 #bajar el cursor
		pass
	if Input.is_action_just_pressed("cancelar"):
		if modo == "extra":
			Auda.beat("res://assets/sound/control.wav")
			modo = "normal"
			sel = 1
			pass
		pass
	if sel == 3:#si el cursor esta en 3 
		sel = 0#asginarle 0
	if sel == -1:#si el cursor es -1
		sel = 2#asignarle 2
	
	$Control/sel.position = get_node(pos[sel]).position # mover el cursor (alma) a la poscicion asignada
	if Input.is_action_just_released("aceptar"):#al dar la tecla asignada (z) 
		Auda.beat("res://assets/sound/done.wav")
		
		if modo == "normal":
			if sel==0:
				get_tree().change_scene("res://scene/start.tscn")
				pass
			if sel==1:
				#get_tree().change_scene("res://mic/menu/music.tscn")
				modo = "extra"
				sel = 0
				pass
			if sel==2:
				get_tree().quit()
				pass
		elif modo == "extra":
			if sel==0:
				get_tree().change_scene("res://mic/menu/music.tscn")
				pass
			if sel==1:
				get_tree().change_scene("res://mic/menu/galery.tscn")
				pass
			if sel==2:
				
				pass
		
		
		pass
	
	
	pass
