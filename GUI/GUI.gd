extends CanvasLayer

func _ready():
	$VBoxContainer/HBoxContainer/Tired.region_enabled = false
	$VBoxContainer/HBoxContainer/Tired/TiredAnimation.get_animation("Tired").set_loop(true)
	$VBoxContainer/HBoxContainer/Tired/TiredAnimation.play("Tired")

func updateEnergy(value):
	$VBoxContainer/HBoxContainer/EnergyBar.rect_size.x = value

func tired(value):
	$VBoxContainer/HBoxContainer/Tired.visible = value