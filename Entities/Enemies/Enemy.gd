extends KinematicBody2D

var allySpotted = false

func _ready():
	pass

func _physics_process(delta):
	surveillance()

func surveillance():
	if !allySpotted:
		var space_state = get_world_2d().direct_space_state
		# use global coordinates, not local to node
		var result = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100))

func spotted(value = true):
	allySpotted = true