extends Control

func is_ani():
	return $ani.is_playing()
func play():
	$ani.play("dif")
	pass
func black():
	$ani.play("black")
	pass
func white():
	$ani.play("ready")
	pass
func get_see():
	var a= true
	if($a/c.color.a==0):a=false
	return(a)
func get_see_invert():
	var a= true
	if($a/c.color.a==1):a=false
	return(a)
func _ready():
	visible = true
	$a/c.visible = true
	Api.set("trans", self)
	pass 
