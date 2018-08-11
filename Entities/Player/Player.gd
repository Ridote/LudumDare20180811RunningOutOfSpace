extends Node2D

#Control
var left = false
var right = false
var slowDown = false
var up = false

#Movement Attributes
var maxSpeed = 10
var normalSpeed = 5
var minSpeed = 1

#GUI
var minEnergyValue = 5
var maxEnergyValue = 50
var currentEnergy = 0

#Code control
var tired = false

func _ready():
	$Mouth/MouthAnimation.get_animation("Mouth").set_loop(true)
	$Mouth/MouthAnimation.play("Mouth")
	currentEnergy = maxEnergyValue

func _physics_process(delta):
	#Keyboard input update
	get_input()
	#Regarding the angle we get the normalised speed (adjusted to one, cause we will increase it depending on the speed)
	var vel = Vector2(sin($Mouth.rotation), -cos($Mouth.rotation)).normalized()
	if up && !tired && currentEnergy > minEnergyValue:
		vel = vel*maxSpeed
		currentEnergy -= 1
	elif slowDown && !tired && currentEnergy > minEnergyValue:
		vel = vel*minSpeed
		currentEnergy -= 1
	else:
		vel = vel*normalSpeed
		currentEnergy += 1
		if currentEnergy > maxEnergyValue:
			currentEnergy = maxEnergyValue
	if currentEnergy == minEnergyValue:
		$SpeedCooldown.start()
		tired = true
		
	#Because we are playing with the orientation to calculate the speed, we will rotate the head to calculate the new speed direction
	if right:
		$Mouth.rotation_degrees+=5
	elif left:
		$Mouth.rotation_degrees-=5
	
	#Update GUI
	updateGUI()
	
	#If we collide either we lost or we ate something
	var collisionObject = move_and_collide(vel)

func get_input():
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	slowDown = Input.is_action_pressed("ui_down")
	up = Input.is_action_pressed("ui_up")

func updateGUI():
	$GUI.updateEnergy(currentEnergy)
	$GUI.tired(tired)

func _on_SpeedCooldown_timeout():
	tired = false
