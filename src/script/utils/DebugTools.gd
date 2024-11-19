extends Node2D

# ADM variables
# ------------------------------------------ #
class CardArea:
	var base = Vector2(0,0)
	var altura = Vector2(0,0)
	var color = Color(1,0, 0)

var debug_navs = [
	
]

export var is_debug = false

var in_half = CardArea.new()
var touch_zone = CardArea.new()

# ------------------------------------------ #

func _ready():
	if is_debug == false:
		set_process(false)

func _process(delta):
	update()


func square_draw(card: CardArea):
	draw_line(Vector2(card.base.x,card.altura.y),Vector2(card.base.y,card.altura.y), card.color)
	draw_line(Vector2(card.base.x,card.altura.y),Vector2(card.base.x,card.altura.x), card.color)
	draw_line(Vector2(card.base.y,card.altura.x),Vector2(card.base.y,card.altura.y), card.color)
	draw_line(Vector2(card.base.x,card.altura.x),Vector2(card.base.y,card.altura.x), card.color)
	

func _draw():
	var card: CardArea = CardArea.new()
	in_half.color = Color(0,1,0)
	touch_zone.color = Color(0,0,1)
	square_draw(in_half)
	square_draw(touch_zone)
	for i in debug_navs:
		var padding = Vector2(0,0)
		var size = i['nave'].rect_scale
		var h_start = i['nave'].rect_position.x  + padding.x - (i['nave'].texture.get_size().x * size.x)/2
		var h_end = i['nave'].rect_position.x + (i['nave'].texture.get_size().x * size.x)/2 + padding.x
		
		var v_start = i['nave'].rect_position.y  + padding.y + (i['nave'].texture.get_size().x * size.x)/2
		
		var v_end = i['nave'].rect_position.y - (i['nave'].texture.get_size().y * size.y)/2 + padding.y
		card.base = Vector2(h_start,h_end)
		card.altura = Vector2(v_start,v_end)
		square_draw(card)
