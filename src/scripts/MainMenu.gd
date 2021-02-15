extends Spatial

var lv_number := 0

func _ready():
	$HUD/DialogBox.visible = false
	$Tuto.play()
	if Globals.DEBUG:
		$HUD/DebugLabel.visible = true
	else:
		$HUD/DebugLabel.visible = false

func _input(event):
	if event is InputEventKey:
		if lv_number > 0 && event.is_action_pressed("accept"):
			Globals.goto_scene("Game")


func _on_Area_body_entered(body):
	if body is KinematicBody:
		lv_number = 1
		$HUD/DialogBox.setText("[center]Level  1\nDifficulty  easy\nPress  Enter[/center]")


func _on_Area_body_exited(body):
	if body is KinematicBody:
		lv_number = 0
		$HUD/DialogBox.setText("")
