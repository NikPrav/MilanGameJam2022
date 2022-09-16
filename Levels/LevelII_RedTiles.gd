extends StaticBody2D

export var layer = 0



func _process(delta):
	var node = get_parent().get_parent()
#	print(node.cur_layer)
	if(int(node.cur_layer) == layer):
		set_collision_mask_bit(0,false);
	else:
		set_collision_mask_bit(0,true);
#	set_collision_mask_bit(1,false);
	pass
