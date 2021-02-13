extends Control

func _ready():
	$DialogBox.visible = false
	if Globals.DEBUG:
		$DebugInfo.visible = true
	else:
		$DebugInfo.visible = false

func _process(_delta):
	# $Heart3.self_modulate.a = min(max(Globals.life - 2.0, 0), 1.0)
	if Globals.DEBUG:
		$DebugInfo.text = "FPS: " + str(Engine.get_frames_per_second())
		$DebugInfo.text += "\nProcess: " + str(stepify(Performance.get_monitor(Performance.TIME_PROCESS) * 1000, 0.01)) + "ms"
		$DebugInfo.text += "\nMemory usage: " + String().humanize_size(int(Performance.get_monitor(Performance.MEMORY_STATIC)))
		$DebugInfo.text += "\nDrawn vertices: " + str(Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))
	if Globals.dialog != "" && not $DialogBox.visible:
		displayDialog(Globals.dialog)
	elif Globals.dialog == "" && $DialogBox.visible:
		undisplayDialog()


func _input(event):
	if Globals.life <= 0 && event is InputEventKey:
		if event.pressed:
			Globals.restart_game()


func displayDialog(text: String):
	$DialogBox.setText(text)
	$DialogBox.visible = true


func undisplayDialog():
	$DialogBox.visible = false
	Globals.dialog = ""


func _on_MuteButton_toggled(button_pressed):
	if button_pressed:
		get_tree().call_group("music", "stop")
	else:
		get_tree().call_group("music", "play")
