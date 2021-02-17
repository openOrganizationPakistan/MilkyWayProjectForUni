# touch screen fire button script
extends Container

onready var button = $HBoxContainer/VBoxContainer/HBoxContainer3/TouchScreenButton;

func _ready():
	
	button.scale =  Global.universal_scale;
	
	pass # Replace with function body.


func _on_TouchScreenButton_pressed():
	Global.byte_array[22] = 1;
	print(Global.byte_array[22]);


func _on_TouchScreenButton_released():
	Global.byte_array[22] = 0;
	print(Global.byte_array[22]);
	
