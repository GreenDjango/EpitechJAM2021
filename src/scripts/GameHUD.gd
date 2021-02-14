extends Control

var dialog_box : Panel = null

func _ready():
	dialog_box = $DialogBox
	dialog_box.visible = false
	if Globals.DEBUG:
		$DebugInfo.visible = true
	else:
		$DebugInfo.visible = false

func _process(_delta):
	# $Heart3.self_modulate.a = min(max(Globals.life - 2.0, 0), 1.0)
	if Globals.DEBUG:
		var debug_str = "FPS: " + str(Engine.get_frames_per_second())
		debug_str += "\nProcess: " + str(stepify(Performance.get_monitor(Performance.TIME_PROCESS) * 1000, 0.01)) + "ms"
		debug_str += "\nMemory usage: " + String().humanize_size(int(Performance.get_monitor(Performance.MEMORY_STATIC)))
		$DebugInfo.text = debug_str
	dialog_box.setText(Globals.dialog)


func _input(event):
	if Globals.life <= 0 && event is InputEventKey:
		if event.pressed:
			Globals.restart_game()


func _on_MuteButton_toggled(button_pressed):
	if button_pressed:
		get_tree().call_group("music", "stop")
	else:
		get_tree().call_group("music", "play")
