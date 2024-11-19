extends Event


var Detrito = preload("res://prefebs/Detritos.tscn")


func _ready():
	start(2, 4, 'meteoro')

func _on_timeout():
	live -= 1
	if Global.Jogo_on == true:
		var meteoros1 = Detrito.instance()
		var meteoros2 = Detrito.instance()
		var meteoros3 = Detrito.instance()
		meteoros1.position.x = rand_range(90,get_viewport().size.x*0.8)
		meteoros2.position.x = Global.nave.pos.x
		meteoros3.position.x = rand_range(90,get_viewport().size.x*0.8)
		meteoros1.position.y = -90
		meteoros2.position.y = -290
		meteoros3.position.y = -190
		grupo.add_child(meteoros1)
		grupo.add_child(meteoros2)
		grupo.add_child(meteoros3)



	if live <= 0:
		emit_signal("finsh")
		queue_free()
