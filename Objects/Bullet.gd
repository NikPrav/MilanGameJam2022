extends Area2D

var layer = 0
var node

const RIGHT = Vector2.RIGHT
export var SPEED = 200

func _physics_process(delta):
	
	node = get_tree().get_current_scene()
	
	if int(node.cur_layer) == layer:
		var movement = RIGHT.rotated(rotation) * SPEED * delta
		global_position += movement
	
		

func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("player") and int(node.cur_layer) == layer:
		body.push_back(position.x)
		body.add_lives(-1)
		
		destroy()
	elif int(node.cur_layer) == layer and !body.is_in_group("enemy"):
		destroy()
