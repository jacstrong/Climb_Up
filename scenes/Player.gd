extends KinematicBody2D

export (int) var run_speed = 350
export (int) var jump_speed = -1000
export (int) var gravity = 2500
export (int) var double_jump_speed = -500
var screensize

var vel = Vector2()
var double_jump = true
var touchInput = false

func _ready():
	screensize = get_viewport_rect().size
	pass

func get_input():
	vel.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up') || touchInput || Input.is_action_just_pressed('ui_accept')
	
	if is_on_floor() and jump:
		vel.y = jump_speed
		double_jump = true
	elif !is_on_floor() and jump and double_jump:
		if vel.y < 0:
			vel.y += double_jump_speed
		else:
			vel.y = double_jump_speed
		double_jump = false
	if right:
		vel.x += run_speed
	if left:
		vel.x -= run_speed
	
	touchInput = false

func _physics_process(delta):
	vel.y += gravity * delta
	get_input()
	vel = move_and_slide(vel, Vector2(0, -1))

func _on_TouchInput_button_down():
	touchInput = true
	pass # replace with function body
