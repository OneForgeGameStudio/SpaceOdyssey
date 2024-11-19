extends "res://script/coletavel.gd"

export var status_change = "impulso"

func _ready():
	scale = idealScale
	blink = true

func _process(delta):
	if position.y >= 300*idealScale.y:
		blink = false
	blink(self, Color(1,1,1,1),delta)
	position.y += (vel*delta)+Global.nave.coeficiente
	#print(Global.nave.pos, position)
	area_limite(self,Vector2(190,190))

func choiced():
	$AnimatedSprite.animation = "default"
	$CollisionShape2D.set_deferred("disabled", true)


func _on_Area2D_area_entered(area):
	#print("Impulos")
	if area.name == "Nave":
		blink = false
		area.get_parent().get_parent().emit_signal("Nave_powerup",status_change)

