extends Label

# ADM variables
# ------------------------------------------ #
class AreaDraw:
	var base = Vector2(0,0)
	var altura = Vector2(0,0)
	var color = Color(1,0, 0)
	var fill = false

class LineDraw:
	var pointA = Vector2(0,0)
	var pointB = Vector2(0,0)
	var color = Color(1,0, 0)
	var width = 1.0

var objectsToDraw = [
	
]

export var is_debug = false


# ------------------------------------------ #

func _ready():
	if is_debug == false:
		set_process(false)

func _process(delta):
	update()

func create_line(origem,destino,experssura,cor):
	var line = LineDraw.new()
	line.pointA = origem
	line.pointB = destino
	line.width = experssura
	line.color = cor
	objectsToDraw.append(
		{
			"type":"line",
			"object":line
		}
	)
	
	

func square_draw(card: AreaDraw):
	draw_line(Vector2(card.base.x,card.altura.y),Vector2(card.base.y,card.altura.y), card.color)
	draw_line(Vector2(card.base.x,card.altura.y),Vector2(card.base.x,card.altura.x), card.color)
	draw_line(Vector2(card.base.y,card.altura.x),Vector2(card.base.y,card.altura.y), card.color)
	draw_line(Vector2(card.base.x,card.altura.x),Vector2(card.base.y,card.altura.x), card.color)
	

func _draw():
	if objectsToDraw.size() > 0:
		for i in objectsToDraw:
			if i["type"] == "line":
				draw_line(
					i["object"].pointA,
					i["object"].pointB,
					i["object"].width, 
					i["object"].color 
					)
		
