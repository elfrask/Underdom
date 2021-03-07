extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos = [
	"L/u/back/nodo/se1",
	"L/u/back/nodo/se2",
	"L/u/back/nodo/se3",
]
var menus = [
	"R/back/items",
	"R/back/info",
	"R/back/tlf",
]
var sel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if visible and !$R/back.visible and !Api.get("say").isplay():
		if Input.is_action_just_pressed("cancelar"):
			visible = false
			pass
		
		if Input.is_action_just_pressed("up"):
			sel -=1
			pass
		if Input.is_action_just_pressed("down"):
			sel +=1
			pass
		
		if sel == 3:
			sel = 0
		if sel == -1:
			sel = 2
		
		$L/u/back/nodo/sec.position = get_node(pos[sel]).position
		if Input.is_action_just_released("aceptar"):
			for x in [0,1,2]:
				get_node(menus[x]).visible = false
				pass
			
			get_node(menus[sel]).visible = true
			$R/back.visible = true
			
			pass
		
		
		pass
	
	pass
	
	if $R/back.visible:
		$L/u/back/nodo/sec.visible = false
		pass
	else: 
		$L/u/back/nodo/sec.visible = true


func _on_pause_visibility_changed():
	
	var dat = game.player["time"]
	var hora = str(int(dat/3600)%100)
	var minuto = str(int((int(dat) % 3600)/(60)))
	var segundo = str(int(dat) % 60)
	if len(segundo) == 1:
		segundo = "0"+segundo
	if len(minuto) == 1:
		minuto = "0"+minuto
	
	$L/d/back/data.text = "" + str(game.player['name']) + "\nG: " + str(game.player['coin'])+ "\n\n\n" + str(game.player['pro']) +"%\n" + str(hora) + ":" + str(minuto) + ":" + str(segundo)
	
	
	pass 
