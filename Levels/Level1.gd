extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cur_layer

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	cur_layer = get_node("Player").cur_layer
