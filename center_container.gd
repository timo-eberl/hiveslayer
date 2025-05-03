extends CenterContainer

func _ready():
	$"VBoxContainer".visible = false

func _on_button_2_pressed():
	$VBoxContainer.visible = true # Replace with function body.


func _on_button_return():
	$VBoxContainer.visible = false # Replace with function body.
