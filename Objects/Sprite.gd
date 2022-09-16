extends AnimatedSprite




func _physics_process(delta):
	var node = get_tree().get_current_scene()
	
	if(node.cur_layer != null):
		
		if(node.cur_layer):
			play("green")
		else:
			play("red")
