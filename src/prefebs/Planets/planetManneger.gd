class_name PlanetManneger
extends Node2D


var lava_wold = preload("res://prefebs/Planets/LavaWorld/LavaWorld.tscn")
var ice_wold = preload("res://prefebs/Planets/IceWorld/IceWorld.tscn")
var land_wold = preload("res://prefebs/Planets/LandMasses/LandMasses.tscn")

var atmosphere_asteroid = preload("res://prefebs/Planets/Asteroids/NoAtmosphere.tscn")
var defaut_asteroid = preload("res://prefebs/Planets/Asteroids/Asteroid.tscn")

export var velocidade = 10 
export var limite = 220

var bg_prefebs = {
	"planets":[
		lava_wold, ice_wold, land_wold
	],
	"asteroids":[
		atmosphere_asteroid, defaut_asteroid
	]
}

var rng = RandomNumberGenerator.new()

func _process(delta):
	self.position.y += (velocidade*delta)*(1+Global.nave.coeficiente)
	if(position.y > get_viewport().size.y + limite or position.x > get_viewport().size.x + limite or position.x < -limite):
		queue_free()
		


func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(0, bg_prefebs.planets.size()-1)
	var planet = bg_prefebs.planets[my_random_number].instance()
	planet.rect_position = Vector2(-295, 0)
	planet.rect_scale = Vector2(8, 8)
	
	self.add_child(planet)


