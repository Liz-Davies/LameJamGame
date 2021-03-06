
extends KinematicBody2D

# This is a simple collision demo showing how
# the kinematic controller works.
# move() will allow to move the node, and will
# always move it to a non-colliding spot, 
# as long as it starts from a non-colliding spot too.

# Member variables
var MOTION_SPEED = 200 # Pixels/seconds
var oldtime=OS.get_unix_time()
var temp=Vector2 (0,0)

func _fixed_process(delta):
	var motion = Vector2()
	if (sqrt(pow(get_parent().x-get_pos().x,2)+pow(get_parent().y-get_pos().y,2))<50):
		print ("human eaten")
		print (get_tree().get_nodes_in_group("enemies").size());
		var temp = get_node("../Timer").get_time_left()+30
		get_node("../Timer").stop()
		get_node("../Timer").set_wait_time(temp)
		get_node("../Timer").start()
		print(get_node("../Timer").get_wait_time())
		queue_free()
		
	if(sqrt(pow(get_parent().x-get_pos().x,2)+pow(get_parent().y-get_pos().y,2))<350):
		MOTION_SPEED = 50 # Pixels/seconds
		if (get_parent().x<get_pos().x):
			motion += Vector2(1, 0)
		if (get_parent().x>get_pos().x):
			motion += Vector2(-1, 0)
		if (get_parent().y<get_pos().y):
			motion += Vector2(0, 1)
		if (get_parent().y>get_pos().y):
			motion += Vector2(0, -1)
	
	if(sqrt(pow(get_parent().x-get_pos().x,2)+pow(get_parent().y-get_pos().y,2))<100):
		MOTION_SPEED = 250 # Pixels/seconds
		if (get_parent().x<get_pos().x):
			motion += Vector2(1, 0)
		if (get_parent().x>get_pos().x):
			motion += Vector2(-1, 0)
		if (get_parent().y<get_pos().y):
			motion += Vector2(0, 1)
		if (get_parent().y>get_pos().y):
			motion += Vector2(0, -1)
	else:
		MOTION_SPEED = 50 # Pixels/seconds
		if(OS.get_unix_time()>oldtime):
			oldtime=OS.get_unix_time()
			var ran =randi()
			if (ran%3==1):
				motion += Vector2(1, 0)
			elif (ran%3==2):
				motion += Vector2(0, 0)
			else:
				motion += Vector2(-1, 0)
			 ran =randi()
			if (ran%3==1):
				motion += Vector2(0, 1)
			elif (ran%3==2):
				motion += Vector2(0, 0)
			else:
				motion += Vector2(0, -1)
			temp=motion
		else:
			motion+=temp
			#print(String(OS.get_unix_time())+" "+String(oldtime))
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1


func _ready():
	
	set_fixed_process(true)
