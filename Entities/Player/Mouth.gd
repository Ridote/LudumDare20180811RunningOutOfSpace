extends KinematicBody2D

var previousPosition = [Vector2(0,0), Vector2(0,0), Vector2(0,0)]
var previousRotation = [0, 0, 0]

func _physics_process(delta):
	previousPosition[0] = previousPosition[1]
	previousRotation[0] = previousRotation[1]
	
	previousPosition[1] = previousPosition[2]
	previousRotation[1] = previousRotation[2]
	
	previousPosition[2] = global_position
	previousRotation[2] = rotation