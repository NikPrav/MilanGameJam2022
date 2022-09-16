extends KinematicBody2D

var SPEED = 50
var GRAV = 20

var cur_velocity = Vector2(0,0)
var frozen = false

var velocity = Vector2(0,0)
export var direction = -1
export var detects_cliffs = true
export var layer = 0

func _ready():
	if direction < 0:
		$Sprite.flip_h = true
	$FloorCheck.position.x =  $CollisionShape2D.shape.get_radius() * direction
	$FloorCheck.enabled = detects_cliffs
	
	if !detects_cliffs:
		set_modulate(Color(0.3,1,1,1))
	pass

func _physics_process(delta):
	
	var node = get_parent().get_parent()
	if(int(node.cur_layer) == layer):
		motion_handler()
	else:
		motion_stop()
	
	if is_on_wall() or (not $FloorCheck.is_colliding() and detects_cliffs) and is_on_floor():
		direction *= -1
		$Sprite.flip_h = !$Sprite.flip_h
		$FloorCheck.position.x =  $CollisionShape2D.shape.get_radius() * direction
	


func motion_handler():	
#	if !frozen:
#		velocity.y += GRAV		
#		velocity.x = direction * SPEED
#	else:
#		velocity = cur_velocity
	if  SPEED > 0:
		start_collisions()
	
	velocity.y += GRAV		
	velocity.x = direction * SPEED
	velocity = move_and_slide(velocity, Vector2.UP)	

func motion_stop():	
	move_and_slide(Vector2(0,0), Vector2.UP)
	stop_collisions()


func _on_Top_checker_body_entered(body):
	stop_collisions()
	print("Player on top")
	$Sprite.play("Kill")
	SPEED = 0
	
	layer = 5
	
	$DeathTimer.start()
	body.bounce()
	pass # Replace with function body.




func _on_Side_checker_body_entered(body):
	print("Player on the side")
#	stop_collisions()
#	body.PlayerDeath(position.x)
	body.push_back(position.x)
	body.add_lives(-1)
	
	pass # Replace with function body.

func stop_collisions():
#	print("Enemy collisions stopped")
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$Top_checker.set_collision_mask_bit(0,false)
	$Side_checker.set_collision_mask_bit(0,false)

func start_collisions():
#	print("Enemy collisions stopped")
	set_collision_layer_bit(4,true)
	set_collision_mask_bit(0,true)
	$Top_checker.set_collision_mask_bit(0,true)
	$Side_checker.set_collision_mask_bit(0,true)

func _on_DeathTimer_timeout():
	queue_free()
