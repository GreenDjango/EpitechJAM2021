extends Spatial

func _ready():
	$HUD/DialogBox.visible = false

func _input(event):
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ENTER:
			Globals.goto_scene("Game")


func _on_Area_body_entered(body):
	if body is KinematicBody:
		$HUD/DialogBox.setText("[center]Level  1\nDifficulty  easy\nPress  Enter[/center]")


func _on_Area_body_exited(body):
	if body is KinematicBody:
		$HUD/DialogBox.setText("")
