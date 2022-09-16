extends StaticBody2D

export var layer = 0

onready var node = get_parent().get_parent()

func _process(delta):
	
	set_colliders()
	pass

func set_colliders():
	
	
#	print("Layer ="+str(layer))
	print(node.cur_layer)
	if(int(node.cur_layer) != layer):
		set_collision_mask_bit(0,false);
	else:
		set_collision_mask_bit(0,true);
