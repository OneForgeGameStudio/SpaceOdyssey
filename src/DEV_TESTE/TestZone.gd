extends Node


var A = load("res://DEV_TESTE/Eventos/A.gd")
var B = load("res://DEV_TESTE/Eventos/B.gd")
var C = load("res://DEV_TESTE/Eventos/C.gd")
var D = load("res://DEV_TESTE/Eventos/D.gd")

var eventos = [
	C,
	A,
	B,
	D
]

var i = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var start = eventos[i].new()
	event_config(start)
	add_child(start)




func event_config(obj):
	obj.connect("finsh", self, "_finish")
	obj.grupo = $Eventos_principais

func _finish():
	i = abs(i)-1
	var start = eventos[abs(i)].new()
	event_config(start)
	add_child(start)
	
	

#
#
#func _on_TestZone_gui_input(event):
#	$Node2D.set_target(event)
