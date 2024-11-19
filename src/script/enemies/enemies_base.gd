extends Bases

var vel = 100
var idealScale = 0

func _ready():
	idealScale = get_viewport().size/Global.idealView
	self.add_to_group("Enemies")


func area_limite(obj,k:Vector2) -> void:
	var paddingY:float = ( k.y * idealScale.y ) # 2000
	var paddingX:float = ( k.x * idealScale.x )
	if( position.y > get_viewport().size.y + paddingY  or position.x > abs(paddingX - get_viewport().size.x) or position.x < - paddingX):
		obj.set_deferred("disabled", true)
		
		queue_free()
	


