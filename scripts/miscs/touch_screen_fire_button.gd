# touch screen fire button script
extends Container

onready var button = $HBoxContainer/VBoxContainer/HBoxContainer3/TouchScreenButton;
#onready var bullets_show= $HBoxContainer/VBoxContainer/HBoxContainer3/TouchScreenButton/Label;

func _ready():
	
	button.shape.extents =  Global._get_viewport_rect();
	print(button.shape.extents)
	

#func _process(_delta):
#	bullets_show.text = str(Global.bullets);
	
	

func _on_TouchScreenButton_pressed():
	Global.byte_array[22] = 1;
	Global.byte_array[23] = 1;
#	Global.byte_array[25] = 1;
#	Global.byte_array[8] = Global.byte_array[24]
#	Global._update_todda_speed();
	print(Global.byte_array[8]);
	

func _on_TouchScreenButton_released():
	Global.byte_array[22] = 0;
	Global.byte_array[23] = 0.2;
#	Global.byte_array[25] = 0;
#	Global.byte_array[8] *= Global.byte_array[23]
#	Global._update_todda_speed();
	print(Global.byte_array[8]);
	

