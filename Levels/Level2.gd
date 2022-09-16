extends Node2D

var cur_layer

func _ready():
	cur_layer = get_node("Player").cur_layer

func _physics_process(delta):
	cur_layer = get_node("Player").cur_layer


func _on_SwitchZone_body_exited(body):
	pass # Replace with function body.
