extends KinematicBody2D

var SPEED = 50
var GRAV = 20

var velocity = Vector2(0,0)
export var direction = -1
export var detects_cliffs = true

func _ready():
	if direction < 0:
		$Sprite.flip_h = true
	$FloorCheck.position.x =  $CollisionShape2D.shape.get_radius() * direction
	$FloorCheck.enabled = detects_cliffs
	
	if !detects_cliffs:
		set_modulate(Color(0.3,1,1,1))
	pass

func _physics_process(delta):
	
	motion_handler()
	
	if is_on_wall() or (not $FloorCheck.is_colliding() and detects_cliffs) and is_on_floor():
		direction *= -1
		$Sprite.flip_h = !$Sprite.flip_h
		$FloorCheck.position.x =  $CollisionShape2D.shape.get_radius() * direction
	


func motion_handler():	
	velocity.y += GRAV
	
	velocity.x = direction * SPEED
	
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Top_checker_body_entered(body):
	print("Player on top")
	$Sprite.play("Kill")
	SPEED = 0
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$Top_checker.set_collision_mask_bit(0,false)
	$Side_checker.set_collision_mask_bit(0,false)
	
	$DeathTimer.start()
	body.bounce()
	pass # Replace with function body.




func _on_Side_checker_body_entered(body):
	print("Player on the side")
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$Top_checker.set_collision_mask_bit(0,false)
	body.PlayerDeath(position.x)
	
	pass # Replace with function body.



func _on_DeathTimer_timeout():
	queue_free()
