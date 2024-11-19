extends Bases

var vel = 100
var idealScale = Vector2(0,0)


func _ready():
	idealScale = get_viewport().size/Global.idealView
	self.add_to_group("Collectibles")


func area_limite(obj,k):
	if(position.y > get_viewport().size.y + (k.y*idealScale.y) or position.x > get_viewport().size.x-(k.x*idealScale.x) or position.x < -(k.x*idealScale.x)):
		#print(position.y, " -> ", get_viewport().size.y + (k.y*idealScale.y))
		obj.set_deferred("disabled", true)
		queue_free()
