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
	previousPosition = [previous.global_position, previous.global_position, previous.global_position]
	previousRotation = [previous.rotation, previous.rotation, previous.rotation]
func setNext(next):
	self.next = next
	
func updateBody():
	#We are keeping track of three positions since we will have 3 different speeds and we don't want to sprite to break or merge
	previousPosition[0] = previousPosition[1]
	previousRotation[0] = previousRotation[1]
	previousPosition[1] = previousPosition[2]
	previousRotation[1] = previousRotation[2]
	previousPosition[2] = global_position
	previousRotation[2] = rotation
	
	global_position = previous.previousPosition[player.speedPhase]
	rotation = previous.previousRotation[player.speedPhase]
	
	if(previous != null):
		global_position = previous.previousPosition[player.speedPhase]
	
	if(previous.has_method("updateBody")):
		previous.updateBody()
	

func _on_Head_body_entered(body):
	#This means that something crushed into our body
	if(body.get_name() == "Enemy" || body.get_name() == "Sentry"):
		player.die()

func die():
	if(next != null):
		next.die()
	queue_free()
	
	
	