extends Event


var Meteoro = preload("res://prefebs/Meteoro.tscn")


func _ready():
	start(2, 5, 'meteoro')

func _on_timeout():
	live -= 1
	if Global.Jogo_on == true:
		var meteoros1 = Meteoro.instance()
		var meteoros2 = Meteoro.instance()

		meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
		meteoros2.tamanho = 0.5
		grupo.add_child(meteoros1)
		grupo.add_child(meteoros2)
	if live <= 0:
		emit_signal("finsh")
		queue_free()
