extends Bases
class_name Tiro



export var speed := 800
export var direction := Vector2(1,1)
var bateu := false
signal bateu
export var color := Color(1,1,1)
var power := 1.0

func _ready():
	self.add_to_group("Projectiles")


func area_limite(obj,padding) -> void:
	if(global_position.y > get_viewport().size.y - padding.y or global_position.x > get_viewport().size.x+(padding.x) or global_position.x < -(padding.x)):
		
		obj.set_deferred("disabled", true)
		queue_free()
		#print("Flamengo")

