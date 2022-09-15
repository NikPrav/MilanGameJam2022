extends TileMap



func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	set_collision_mask_bit(0,true);
	set_collision_mask_bit(1,false);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
