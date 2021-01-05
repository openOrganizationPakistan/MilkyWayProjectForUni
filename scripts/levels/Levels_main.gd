extends Node2D

func _return_level(index):
	return get_child(index).duplicate();
	

