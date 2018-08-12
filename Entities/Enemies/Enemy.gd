extends KinematicBody2D

var playerSpotted = false
var speed = 1
var speedRunning = 10


func _ready():
	pass

func _physics_process(delta):
	move()
	
func think():
	var distance2Player = self.global_position.distance_to(get_parent().get_node("Player").get_node("Mouth").global_position); 
	print("distance2Player: ", distance2Player)
	if distance2Player < 300 && !playerSpotted:
		playerSpotted = true
		$Calm.start()
	handleRotation()
		
func move():
	var vel = Vector2(sin(self.rotation), -cos(self.rotation)).normalized()
	if not playerSpotted:
		move_and_collide(vel * speed)
	if playerSpotted:
		move_and_collide(vel * (speedRunning))

func rotate_degrees(degrees):
	self.rotate(deg2rad(degrees))
	
func calmdown():
	playerSpotted = false
	
func handleRotation():
	if !$View31.is_colliding() && !$View32.is_colliding() && !$View33.is_colliding():
		return;
	if not $View2.is_colliding():
		rotate(-45)
		return;
	if not $View4.is_colliding():
		rotate(45)
		return;
	if not $View1.is_colliding():
		rotate(-90)
		return;
	if not $View5.is_colliding():
		rotate(90)
		return;
	if not $View6.is_colliding():
		rotate(-135)
		return;
	if not $View7.is_colliding():
		rotate(135)
		return;
	rotate(180)
	
func detect(name):
	match name:
		"Body", "Head":
			return "player"
		"Wall":
			return "wall"
		_: 
			return "nothing"