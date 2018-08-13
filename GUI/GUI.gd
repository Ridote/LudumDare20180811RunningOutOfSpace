extends CanvasLayer

var playerFactory = preload("res://Entities/Player/Player.tscn")
var humanFactory = preload("res://Entities/Enemies/Enemy.tscn")

func _ready():
	$VBoxContainer/HBoxContainer2/Tired.region_enabled = false
	$VBoxContainer/HBoxContainer2/Tired/TiredAnimation.get_animation("Tired").set_loop(true)
	$VBoxContainer/HBoxContainer2/Tired/TiredAnimation.play("Tired")

func updateGUI(energy, tired, blood, humans, robots, points):
	$VBoxContainer/HBoxContainer/EnergyBar.rect_size.x = energy
	$VBoxContainer/HBoxContainer2/Blood.text = str(blood)
	$VBoxContainer/HBoxContainer2/Humans.text = str(humans)
	$VBoxContainer/HBoxContainer2/Robots.text = str(robots)
	$VBoxContainer/HBoxContainer2/Points.text = str(points)
	$VBoxContainer/HBoxContainer2/Tired.visible = tired

func start():
	var player = playerFactory.instance()
	player.global_position = get_parent().get_node("Map1").get_node("StartPosition").global_position
	get_parent().add_child(player)
	get_parent().get_node("Player").startTimer()
	addEnemies()
	$MainMenu.hide()
	
func showMainMenu():
	removeEnemies()
	$MainMenu.show()

func addEnemies():
	var children = get_parent().get_node("Map1").get_children()
	for child in children:
		if "HumanPosition" in child.get_name():
			var human = humanFactory.instance()
			human.global_position = child.global_position
			get_parent().add_child(human)
			
func removeEnemies():
	var children = get_parent().get_children()
	for child in children:
		if "Enemy" in child.get_name():
			child.queue_free()