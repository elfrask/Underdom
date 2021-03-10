extends Control


func is_ani():
	
	return $ani.is_playing()

func play():
	$ani.play("dif")
	pass


func _ready():
	Api.set("trans", self)
	pass 
