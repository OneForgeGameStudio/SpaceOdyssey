extends Event


var Meteoro = preload("res://prefebs/Meteoro.tscn")
var Detrito = preload("res://prefebs/Detritos.tscn")
var a = 2
var lista = []

func _ready():
	start(2, 5, 'meteoro')

func _on_timeout():
	live -= 1
	if Global.Jogo_on == true and live > 0:
		var meteoros1 = Meteoro.instance()
		if a > 2:
			var meteoros2 = Meteoro.instance()
			grupo.add_child(meteoros1)
			grupo.add_child(meteoros2)
			var detrito1 = Detrito.instance()
			detrito1.position.x = Global.nave.pos.x
			meteoros1.position.y = -90
			grupo.add_child(detrito1)
		else:
			grupo.add_child(meteoros1)
			meteoros1.position.x = Global.nave.pos.x
			a = 3


	if live <= 0:
		if grupo.get_children().size() <= 0:
			emit_signal("finsh")
			queue_free()
