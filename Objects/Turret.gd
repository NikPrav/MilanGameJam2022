extends Node2D

#var target: Node2D = null

export(PackedScene) var BULLET: PackedScene =  null

var target = null
#export 
onready var gunSprite = $GunSprite
onready var raycast = $RayCast2D
onready var timer = $RayCast2D/ShootTimer

func _ready():
	yield(get_tree(),"idle_frame")
	target = find_target()

func _physics_process(delta):
	if target != null:
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		raycast.global_rotation = angle_to_target
#		print(angle_to_target)
		if raycast.is_colliding() and raycast.get_collider().is_in_group("player"):
			gunSprite.rotation = angle_to_target + 3.14/2
			if timer.is_stopped():
				shoot()

func shoot():
	print("fire")
	$RayCast2D.enabled = false
	
	if BULLET:
		var bullet = BULLET.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = raycast.global_rotation
	
	timer.start()

func find_target():
	var new_target
	
	if get_tree().has_group("player"):
		new_target  = get_tree().get_nodes_in_group("player")[0]

	return new_target




func _on_ShootTimer_timeout():
	raycast.enabled = true
