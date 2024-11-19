extends Node2D


# Declare member variables here. Examples:
var pos_inicial
var escala 
var b = Color(0.011765, 0.039216, 0.133333)
# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = b
	pos_inicial = self.position
	escala = 0
	scale *= 0.5
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.y += (3*delta)*(1+Global.nave.coeficiente)
	escala = (self.position.y - pos_inicial.y)/get_viewport().size.y
	if self.scale.x <= 6:
		self.scale += Vector2((escala),(escala))*delta
	b += Color(0.011765, 0.039216, 0.0133333)*delta*0.1
	modulate = Color(b.r,b.g, b.b,1)
	#print(scale)

