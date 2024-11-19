extends Event


var Parede = preload("res://prefebs/Paredes.tscn")

func _ready():
	start(3, 4, 'paredes')


func _on_timeout():
	live -= 1
	if Global.Jogo_on == true:
		
		var Paredes = Parede.instance()
		grupo.add_child(Paredes)
	if live <= 0:
		emit_signal("finsh")
		queue_free()
