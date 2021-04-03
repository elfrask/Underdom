extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sel = 0
var pos = [
	"main/Tfont/sec1",
	"main/Tfont/sec2",
	"main/Tfont/sec3",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("up"): #al dar la tecla asignada (arriba)
		sel -=1 #subir el cursor
		pass
	if Input.is_action_just_pressed("down"): # al dar a la tecla asignada (abajo)
		sel +=1 #bajar el cursor
		pass
	
	if sel == 3:#si el cursor esta en 3 
		sel = 0#asginarle 0
	if sel == -1:#si el cursor es -1
		sel = 2#asignarle 2
	
	$main/Tfont/sel.position = get_node(pos[sel]).position # mover el cursor (alma) a la poscicion asignada
	if Input.is_action_just_released("aceptar"):#al dar la tecla asignada (z) 
		
		if sel==0:
			get_tree().change_scene("res://scene/start.tscn")
			pass
		if sel==1:
			get_tree().change_scene("res://mic/menu/music.tscn")
			pass
		if sel==2:
			get_tree().quit()
			pass
		
		
		pass
	
	
	pass
