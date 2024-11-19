extends Event



var move_enemy = preload("res://prefebs/enemies/move_enemy.tscn")

func _ready():
	get_parent().get_parent().emit_signal("new_planet")
	var enemy1 = move_enemy.instance()
	var enemy2 = move_enemy.instance()
	enemy2.position.x = get_viewport().size.x - 40
	enemy1.position.y = -40
	enemy2.position.y = -40
	grupo.add_child(enemy1)
	grupo.add_child(enemy2)
	start(2, 5, '_easy_wave') # Basic medium hard
	

func _on_timeout():
	live -= 1
	if Global.Jogo_on == true:
		pass

	if live <= 0:
		if grupo.get_children().size() <= 0:
			emit_signal("finsh")
			queue_free()
