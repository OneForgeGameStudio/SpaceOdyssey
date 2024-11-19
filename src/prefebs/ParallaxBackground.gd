extends ParallaxBackground

export var velocidade = 150 #30
signal new_planet
var asteroid_rotation = 0

func _ready():
	asteroid_rotation = rand_range((0.2),(-0.2))
	scale = get_viewport().size/ Global.idealView
	$terceiro/ColorRect.rect_size = get_viewport().size*2
	#print(get_viewport().size)
	#print(scale)
	#OS.alert("Scala: "+str(scale))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.scroll_offset.y += (1+Global.nave.coeficiente)*(velocidade*delta)
	asteroid_rotation += delta
	
#	$primeiro/NoAtmosphere.rect_rotation =  (asteroid_rotation*30)
#	$primeiro/NoAtmosphere2.rect_rotation = (asteroid_rotation*20)
#	$primeiro/NoAtmosphere3.rect_rotation = (asteroid_rotation*8)
#	$primeiro/NoAtmosphere4.rect_rotation = (asteroid_rotation*10)
#	$primeiro/NoAtmosphere5.rect_rotation = (asteroid_rotation*-20)
#	$primeiro/NoAtmosphere6.rect_rotation = (asteroid_rotation*20)
#	$primeiro/NoAtmosphere7.rect_rotation = (asteroid_rotation*-20)
	$segundo/NoAtmosphere2.rect_rotation = (asteroid_rotation*-10)
	$terceiro2/NoAtmosphere3.rect_rotation = (asteroid_rotation*8)
	$segundo/Asteroid.rect_rotation = (asteroid_rotation*13)
	$segundo/Asteroid2.rect_rotation = (asteroid_rotation*13)
	$segundo/Asteroid3.rect_rotation = (asteroid_rotation*-10)

func _on_ParallaxBackground_new_planet():
	var planetInstance = PlanetManneger.new()
	planetInstance.position = Vector2(0,-1580)
	$planet.add_child(planetInstance)

