extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	pass

func _process(delta):
	if(Input.is_action_just_pressed("ui_select")):
		get_tree().paused = !get_tree().paused
	showPauseScreen(get_tree().paused)
func showPauseScreen(value):
	if value:
		$Pause/CanvasModulate.show()
		$Pause/Label.show()
	else:
		$Pause/CanvasModulate.hide()
		$Pause/Label.hide()