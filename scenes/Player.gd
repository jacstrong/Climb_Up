extends KinematicBody2D

export (int) var run_speed = 350
export (int) var jump_speed = -1000
export (int) var gravity = 2500
var screensize

var vel = Vector2()

func _ready():
	screensize = get_viewport_rect().size
	pass

func get_input():
	vel.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_pressed('ui_up')
	
	if is_on_floor() and jump:
		vel.y = jump_speed
	if right:
		vel.x += run_speed
	if left:
		vel.x -= run_speed

func _physics_process(delta):
	vel.y += gravity * delta
	get_input()
	vel = move_and_slide(vel, Vector2(0, -1))