extends Node2D

func _get_power_up(index):
	return get_child(index).duplicate();
	
