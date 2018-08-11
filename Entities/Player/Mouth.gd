extends KinematicBody2D

var previousPosition = Vector2(0,0)
var previousRotation = 0

func _physics_process(delta):
	previousPosition = global_position
	previousRotation = rotation