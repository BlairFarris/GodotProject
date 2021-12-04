extends Area2D


# Declare member variables here. Examples:
var tile_size = 64
var inputs = {"move_left": Vector2.LEFT, "move_right": Vector2.RIGHT,
"move_up": Vector2.UP, "move_down": Vector2.DOWN}
onready var ray = $RayCast2D
onready var tween = $Tween

export var speed = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		move_tween(dir)

func move_tween(dir):
	tween.interpolate_property(self, "position", position, 
	position + inputs[dir] * tile_size, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
