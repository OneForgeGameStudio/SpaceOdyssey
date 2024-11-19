extends Tiro

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = color
	blink = true
	$AnimaTiro.animation = "normal"
	$AudioStreamPlayer2D.playing = true



func _process(delta):
	blink(self, Color(1,1,1,0),delta)
	
	area_limite($CollisionShape2D,Vector2(10,10))
	if(bateu == false):
		position += (speed*direction)*delta
	if Global.Jogo_on == false:
		queue_free()




func _on_Tiro_c_bateu():
	bateu = true
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimaTiro.animation = "explodi"
	yield(get_tree().create_timer(0.1),"timeout")
	queue_free()


func _on_Tiro_c_area_entered(area):
	if get_parent().name != area.name and not area.is_in_group("Projectiles"):
		emit_signal("bateu")
