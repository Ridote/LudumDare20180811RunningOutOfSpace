extends CanvasLayer

var playerFactory = preload("res://Entities/Player/Player.tscn")
var humanFactory = preload("res://Entities/Enemies/Enemy.tscn")
var sentryFactory = preload("res://Entities/Sentry/Sentry.tscn")

var globalblood = 0
var globalhumans = 0
var globalrobots = 0
var globalpoints = 0

func _ready():
	$EnergyBar.hide()

func updateGUI(energy, tired, blood, humans, robots, points):
	$EnergyBar/EnergyBar.rect_size.x = energy
	$Score/Blood.text = str(blood)
	$Score/Humans.text = str(humans)
	$Score/Robots.text = str(robots)
	$Score/Points.text = str(points)
	globalblood = blood
	globalhumans = humans
	globalrobots = robots
	globalpoints = points

func start():
	var player = playerFactory.instance()
	player.global_position = get_parent().get_node("Map1").get_node("StartPosition").global_position
	get_parent().add_child(player)
	get_tree().paused = false
	get_parent().get_node("Player").startTimer()
	addEnemies()
	$EnergyBar.show()
	$MainMenu.hide()
	
func showMainMenu():
	removeEnemies()
	$EnergyBar.hide()
	if OS.has_feature('JavaScript'):
        JavaScript.eval("newScore(" + String(globalblood) + "," + String(globalhumans) + "," + String(globalrobots) + "," + String(globalpoints) + ")")
	$MainMenu.show()

func addEnemies():
	var children = get_parent().get_node("Map1").get_children()
	for child in children:
		if "HumanPosition" in child.get_name():
			var human = humanFactory.instance()
			human.global_position = child.global_position
			get_parent().add_child(human)
		elif "SentryPosition" in child.get_name():
			var sentry = sentryFactory.instance()
			sentry.global_position = child.global_position
			get_parent().add_child(sentry)
			
func removeEnemies():
	var children = get_parent().get_children()
	for child in children:
		if "Enemy" in child.get_name():
			child.queue_free()
		elif "SentryPosition" in child.get_name():
			child.queue_free()