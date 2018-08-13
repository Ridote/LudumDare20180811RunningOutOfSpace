extends Node2D


var playerSpotted = false
var torque = 5
var sightDistance = 100000
var player = null
var objective = Vector2(0,0)
func _ready():
	pass

func _physics_process(delta):
	player = get_parent().get_node("Player")
	#If player hasn't been deleted
	if weakref(player).get_ref():
		think()

func think():
	var collision_mask = 15 #Mouth, head, body and walls
	var result = get_world_2d().direct_space_state.intersect_ray(global_position, player.get_node("Mouth").global_position, [self], collision_mask)
	if result:
		match result.collider.get_name():
			"Body", "Head", "Mouth", "Tail":
				objective = player.get_node("Mouth").global_position
			_: 
				pass
		lookAt(result.collider.global_position)

func lookAt(position):
	#This should be smooth
	look_at(position)
	rotation += PI/2

func die():
	queue_free()

func _on_Area2D_body_entered(body):
	print(body.get_name())
	match body.get_name():
		"Mouth":
			player.eatRobot()
			queue_free()
		_:
			if body.has_method("die"):
				$body.die()
