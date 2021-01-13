extends Node2D

onready var boss = $Boss;
onready var level_change = $level_change;

func _return_level(index):
	return get_child(index).duplicate();
	

