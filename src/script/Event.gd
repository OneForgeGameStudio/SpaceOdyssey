class_name Event extends Node

var my_timer = Timer.new()
export var live:float = 1.0

var grupo

signal finsh


# Override virtual methods
func start(timer, live_, name_):
	name = name_
	live = live_
	my_timer.connect("timeout", self, "_on_timeout")
	my_timer.wait_time = timer
	my_timer.autostart = true
	add_child(my_timer)

