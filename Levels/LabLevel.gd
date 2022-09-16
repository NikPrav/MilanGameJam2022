extends Node2D

var cur_layer

func _physics_process(delta):
	cur_layer = get_node("Player").cur_layer
