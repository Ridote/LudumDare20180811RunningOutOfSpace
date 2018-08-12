extends KinematicBody2D

var playerSpotted = false
var speed = 1

func _ready():
	pass

func _physics_process(delta):
	if $View.is_colliding():
		if detect($View.get_collider().get_name()) == "player":
			rotate_degrees(180)
			playerSpotted = true
	move()
		
func move():
	var vel = Vector2(sin(self.rotation), -cos(self.rotation)).normalized()
	if playerSpotted:
		move_and_collide(vel * speed)
	if playerSpotted:
		move_and_collide(vel * speed * 2)

func rotate_degrees(degrees):
	self.rotate(deg2rad(degrees))
	
func handleRotation():
	if not $View3.is_colliding():
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