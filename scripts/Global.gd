extends Node

var game_speed = 1;

var player_health = 100;

var player_fire_damage = 0;

var boss_health = 1000;

var enemy_damage = 0;
var enemy_c_health = 0;

onready var x_ratio;
onready var y_ratio;

func _ready():
	x_ratio = _get_viewport_rect().x/480;
	y_ratio = _get_viewport_rect().y/640;
	

func _get_viewport_rect():
	return get_viewport().get_visible_rect().size
	

