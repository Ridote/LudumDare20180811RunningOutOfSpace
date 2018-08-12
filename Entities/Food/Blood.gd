extends Area2D

func _ready():
	pass

func _on_Blood_body_entered(body):
	body.player.eatBlood()
	queue_free()