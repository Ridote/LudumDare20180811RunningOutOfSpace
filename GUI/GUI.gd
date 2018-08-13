extends CanvasLayer

var playerFactory = preload("res://Entities/Player/Player.tscn")
var humanFactory = preload("res://Entities/Enemies/Enemy.tscn")

func _ready():
	$EnergyBar.hide()

func updateGUI(energy, tired, blood, humans, robots, points):
	$EnergyBar/EnergyBar.rect_size.x = energy
	$Score/Blood.text = str(blood)
	$Score/Humans.text = str(humans)
	$Score/Robots.text = str(robots)
	$Score/Points.text = str(points)

func start():
	var player = playerFactory.instance()
	player.global_position = get_parent().get_node("Map1").get_node("StartPosition").global_position
	get_parent().add_child(player)
	get_parent().get_node("Player").startTimer()
	addEnemies()
	$EnergyBar.show()
	$MainMenu.hide()
	
func showMainMenu():
	removeEnemies()
	$EnergyBar.hide()
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