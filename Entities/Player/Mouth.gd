extends KinematicBody2D

var previousPosition = [Vector2(0,0), Vector2(0,0)]
var previousRotation = [0, 0]

func _physics_process(delta):
	previousPosition[0] = previousPosition[1]
	previousRotation[0] = previousRotation[1]
	
	previousPosition[1] = global_position
	previousRotation[1] = rotation