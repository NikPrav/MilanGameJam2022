extends StaticBody2D

export var layer = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	
	set_colliders()
	pass

func set_colliders():
	var node = get_parent().get_parent()
	
#	print("Layer ="+str(layer))
#	print(node.cur_layer)
	if(int(node.cur_layer) != layer):
		set_collision_mask_bit(0,false);
	else:
		set_collision_mask_bit(0,true);
