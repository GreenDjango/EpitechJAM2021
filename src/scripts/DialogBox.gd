extends Panel

func _ready():
	pass

func setText(text: String):
	if text:
		$RichTextLabel.bbcode_text = text
		visible = true
	else:
		$RichTextLabel.text = ""
		visible = false
