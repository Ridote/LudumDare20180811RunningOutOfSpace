extends Area2D

var player = null
var previous = null
var next = null

var previousPosition = []
var previousRotation = []

func _ready():
	pass

func setBodies(player, previous, next):
	self.player = player
	self.previous = previous
	self.next = next
	previousPosition = [previous.global_position, previous.global_position]
	previousRotation = [previous.rotation, previous.rotation]
	
func setNext(next):
	self.next = next
	
func updateBody():
	previousPosition[0] = previousPosition[1]
	previousRotation[0] = previousRotation[1]
	previousPosition[1] = global_position
	previousRotation[1] = rotation
	global_position = previous.previousPosition[0]
	rotation = previous.previousRotation[0]
	if(previous != null):
		global_position = previous.previousPosition[0]# - Vector2(sin(previous.previousRotation), -cos(previous.previousRotation)).normalized()*16
	
	if(previous.has_method("updateBody")):
		previous.updateBody()
	

func _on_Head_area_entered(area):
	#player.die()
	print("Collision")
