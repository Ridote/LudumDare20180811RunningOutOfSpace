extends Node2D

var enemyPrefab = preload("res://Entities/Enemies/Enemy.tscn")

func _ready():
	var enemy = enemyPrefab.instance()
	enemy.player = $Player
	self.add_child(enemy)

