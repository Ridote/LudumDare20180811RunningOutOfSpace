extends CanvasLayer

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