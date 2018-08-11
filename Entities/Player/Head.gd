extends Area2D

var player = null
var previous = null
var next = null

var previousPosition = 0
var previousRotation = 0

func _ready():
	pass

func setBodies(player, previous, next):
	self.player = player
	self.previous = previous
	self.next = next
	
func attachNext(next):
	self.next = next
	
func updateBody():
	previousPosition = global_position
	previousRotation = rotation
	global_position = previous.previousPosition
	rotation = previous.previousRotation
	if(previous != null):
		global_position = previous.previousPosition - Vector2(sin(previous.previousRotation), -cos(previous.previousRotation)).normalized()*32
	
	if(next != null):
		next.updateBody()
	

func _on_Head_area_entered(area):
	#player.die()
	print("Collision")
