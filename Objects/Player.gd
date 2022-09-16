extends KinematicBody2D


enum States {FLOOR = 1, AIR, WALL, IDLE }

var state = States.AIR
var velocity
var coins
var can_change_layer
var direction = 1

const DRAG = 0.4
const SPEED = 450
const GRAV = 30
const JSPEED = -1000

var cur_layer = 0
var small_x = 0.1


func _ready():
	velocity = Vector2(0,0)
	coins = 0
	can_change_layer = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var last_jump_direction
# Game Loop
# Not tied to frame rate
func _physics_process(delta):
	
	var slow_fall = false
	
#	print(is_near_wall())
	
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			elif is_near_wall():
				state = States.WALL
			if(velocity.y < 0):
				$Sprite.play("jump")
			else:
				$Sprite.play("fall")
			input_controller()
			
		States.FLOOR:
			last_jump_direction = 0
			if !is_on_floor():
				state = States.AIR
				continue
			if velocity.x > small_x:
				$Sprite.play("walk")
			else:
				$Sprite.play("idle")
			if Input.is_action_just_pressed("jump"):
				velocity.y = JSPEED
			input_controller()
		States.WALL:
			if is_on_floor():
				state = States.FLOOR
				continue
			elif !is_near_wall():
				state = States.AIR
				continue
#			input_controller()
			slow_fall = true
			
			# Wall Jump Check
			if direction != last_jump_direction :
				if Input.is_action_just_pressed("jump") and (Input.is_action_pressed("left") and direction == 1) or (Input.is_action_pressed("right") and direction == -1):
					last_jump_direction = direction
					velocity.x = 450 * -direction
					velocity.y = JSPEED * 0.7
					
#	Change Layer	
	if Input.is_action_just_pressed("change_layer") and can_change_layer:
		set_layer(!cur_layer)
	
	set_direction()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JSPEED
	
	# Updating Velocity
	move_and_fall(slow_fall)
	
	

func move_and_fall(slow_fall: bool):
	#Gravity
	velocity.y += GRAV
	
	if(slow_fall):
		velocity.y = clamp(velocity.y,JSPEED,200)
	
	
	
	# Linear interpolation for Drag
	velocity.x = lerp(velocity.x, 0,DRAG)
	velocity = move_and_slide(velocity, Vector2.UP)

func input_controller():
	
	var s
	
	match state:
		States.AIR:
#			s = lerp(velocity.x,SPEED,0.1) if velocity.x < SPEED else lerp(velocity.x,SPEED,0.03)
			s = SPEED
		States.FLOOR:
			s = SPEED
		States.WALL:
			s = 0
	print(state)
	if Input.is_action_pressed("right"):
		velocity.x = s
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = s*-1
		$Sprite.flip_h = true
		


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

func is_near_wall():
#	print($WallChecker.rotation_degrees)
	return $WallChecker.is_colliding()
	

func set_direction():
	direction = 1 if not $Sprite.flip_h  else -1
	$WallChecker.rotation_degrees  = -90 * direction

func _on_DeathTimer_timeout():
#	get_tree().change_scene("res://Levels/Level1.tscn")
	get_tree().change_scene("res://Levels/"+get_tree().get_current_scene().get_name()+".tscn")


func _on_SwitchZone_body_entered(body):
	print("Body entered the zone")
	can_change_layer = true


func _on_SwitchZone_body_exited(body):
	print("Body exited the zone")
	can_change_layer = false



