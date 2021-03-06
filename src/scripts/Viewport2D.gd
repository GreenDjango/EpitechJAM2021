extends Node2D

var viewport_initial_size = Vector2()

onready var viewport = $Viewport
onready var viewport_sprite = $RenderSprite

func _ready():
	# We want Godot to load everything but be hidden for a bit.
	# viewport_sprite.modulate = Color(1, 1, 1, 0.01)
	#warning-ignore:return_value_discarded
	# get_viewport().connect("size_changed", self, "_root_viewport_size_changed")
	viewport_initial_size = viewport.size

	# Assign the sprite's texture to the viewport texture.
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)

	# Let two frames pass to make sure the screen was captured.
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	viewport_sprite.texture = viewport.get_texture()


# Called when the root's viewport size changes (i.e. when the window is resized).
# This is done to handle multiple resolutions without losing quality.
func _root_viewport_size_changed():
	# The viewport is resized depending on the window height.
	# To compensate for the larger resolution, the viewport sprite is scaled down.
	viewport.size = Vector2.ONE * get_viewport().size.y
	viewport_sprite.scale = Vector2.ONE * viewport_initial_size.y / get_viewport().size.y
