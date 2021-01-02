extends Node

func _get_viewport_rect():
	return get_viewport().get_visible_rect().size

var game_speed = 1
