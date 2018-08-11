extends Node2D

#External classes
var bodyPrefab = preload("res://Entities/Player/Body.tscn")

#Control
var left = false
var right = false
var slowDown = false
var up = false
var growButton = false
var canGrow = true

#Movement Attributes
var maxSpeed = 20
var normalSpeed = 10
var minSpeed = 5

#GUI
var minEnergyValue = 5
var maxEnergyValue = 50
var currentEnergy = 0

#Code control
var tired = false
var previousPosition = Vector2()
var previousAngle = 0

func _ready():
	$Mouth/Mouth/MouthAnimation.get_animation("Mouth").set_loop(true)
	$Mouth/Mouth/MouthAnimation.play("Mouth")
	currentEnergy = maxEnergyValue
	$Head.setBodies(self, $Mouth, $Body)
	$Body.setBodies(self, $Head, $Tail)
	$Tail.setBodies(self, $Body, null)

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
		
	if growButton && canGrow:
		$WaitUntilNewGrouth.start()
		canGrow = false
		grow()
		
	#Because we are playing with the orientation to calculate the speed, we will rotate the head to calculate the new speed direction
	if right:
		$Mouth.rotation_degrees+=5
	elif left:
		$Mouth.rotation_degrees-=5
	
	#Update GUI
	updateGUI()
	
	previousPosition = global_position
	previousAngle = global_rotation
	#If we collide either we lost or we ate something
	var collisionObject = $Mouth.move_and_collide(vel)
	
	updateBody()

func get_input():
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	slowDown = Input.is_action_pressed("ui_down")
	up = Input.is_action_pressed("ui_up")
	growButton = Input.is_key_pressed(KEY_G)
	
func updateGUI():
	$GUI.updateEnergy(currentEnergy)
	$GUI.tired(tired)
	
func canGrowAgain():
	canGrow = true

func _on_SpeedCooldown_timeout():
	tired = false

func updateBody():
	$Head.updateBody()

func grow():
	var body = bodyPrefab.instance()
	var prevBody = $Tail.previous
	prevBody.setNext(body)
	body.setBodies(self, prevBody, $Tail)
	$Tail.setBodies(self, body, null)
	$Tail.player.add_child(body)

func die():
	print("Die not implemented yet")
	queue_free()