extends KinematicBody2D

var velocity
var coins
var can_change_layer

const DRAG = 0.4
const SPEED = 250
const GRAV = 30
const JSPEED = -1000

var cur_layer = 0



func _ready():
	velocity = Vector2(0,0)
	coins = 0
	can_change_layer = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Game Loop
# Not tied to frame rate
func _physics_process(delta):
	
#	Movement Controller
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -1*SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	
#	Change Layer	
	if Input.is_action_just_pressed("change_layer") and can_change_layer:
		set_layer(!cur_layer)
	
#	Checking if the player is on the floor
	if not is_on_floor():
		if(velocity.y < 0):
			$Sprite.play("jump")
		else:
			$Sprite.play("fall")
	
	# Adding Gravity
	velocity.y += GRAV	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JSPEED
	
	

	# print("velocity.y %f" % velocity.y)
	# Updating Velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	# Linear Interpolation
	velocity.x = lerp(velocity.x, 0,DRAG)
	




func _on_FallZone_body_entered(body):
	print("Inside the zone")
	print(get_tree().get_current_scene().get_name())
	get_tree().change_scene("res://Levels/"+get_tree().get_current_scene().get_name()+".tscn")
	

func set_layer(a):
	cur_layer = a

func add_coin():
	coins += 1


	
	

func bounce():
	velocity.y = 0.75*JSPEED

func PlayerDeath(var eposx):
	set_modulate(Color(1,0.2,0.2,0.4))
	velocity.y = 0.5*JSPEED
	
	if position.x < eposx:
		velocity.x = -800
	else:
		velocity.x = 800
	
	Input.action_release("left")
	Input.action_release("right")
	
	$DeathTimer.start()
#	get_tree().change_scene("res://Levels/Level1.tscn")




func _on_DeathTimer_timeout():
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_SwitchZone_body_entered(body):
	print("Body entered the zone")
	can_change_layer = true


func _on_SwitchZone_body_exited(body):
	print("Body exited the zone")
	can_change_layer = false
