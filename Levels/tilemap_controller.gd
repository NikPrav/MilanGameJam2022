extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	var node = get_parent().get_parent()
#	print(node.cur_layer)
	if(node.cur_layer):
		set_collision_mask_bit(0,false);
	else:
		set_collision_mask_bit(0,true);
#	set_collision_mask_bit(1,false);
	pass
