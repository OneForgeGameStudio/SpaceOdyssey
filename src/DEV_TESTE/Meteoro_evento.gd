extends Event


var Meteoro = preload("res://prefebs/Meteoro.tscn")


func _on_timeout():
	live -= 1
	#print("start: ", live)
	var meteoros1 = Meteoro.instance()
	var meteoros2 = Meteoro.instance()
	meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
	meteoros2.tamanho = 0.5
	#print("Grupo: ", grupo)
	if grupo:
		grupo.add_child(meteoros1)
		grupo.add_child(meteoros2)

	if live <= 0:
		emit_signal("finsh")
		queue_free()
